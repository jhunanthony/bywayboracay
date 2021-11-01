import 'dart:collection';
import 'dart:io';

import 'package:bywayborcay/pages/MainPage.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/LogIn.dart';
import 'package:bywayborcay/widgets/CalendarWidget/emailtext.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:table_calendar/table_calendar.dart';
import 'auth.dart';
import 'datepicker.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarPage> {
  List<String> emails = [Auth().getCurrentUser().email];
  LinkedHashMap kEvents = LinkedHashMap();
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  List<Map<DateTime, List<Event>>> events2 = [];
  TextEditingController event = TextEditingController();
  TextEditingController timer = TextEditingController();
  TextEditingController desc = TextEditingController();
  File file = File('lib/input.docx');
  DateTime _selectedDay;
  RegExp time_24H = new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$");
  RegExp time_12H =
      new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9]) ?((a|p)m|(A|P)M)$");
  List tapTitles = [
    "Are you sure you want to delete the event?",
    "Are you sure you want to send  the event reminders?"
  ];
  Timestamp t;
  DateTime eventDate = DateTime.now();
  Map res = Map();
  Future<void> getEventData(String s) async {
    var d = await databaseReference
        .collection("Users")
        .doc(s)
        .collection("Events")
        .get();
    List<DateTime> dates = [];
    events2 = [];
    for (int i = 0; i < d.docs.length; i++) {
      List temp = (d.docs[i].get("EventList"));
      print(temp);
      dates.add(DateFormat('yyyy-MM-dd').parse(d.docs[i].id));
      events2.add({
        DateFormat('yyyy-MM-dd').parse(d.docs[i].id): List.generate(
            temp.length,
            (index) => Event(
                temp[index]["Event"],
                temp[index]["users"],
                temp[index]["description"],
                temp[index]["time"],
                temp[index]["CreatedBy"]))
      });
    }
    Map<DateTime, List<Event>> k =
        Map.fromIterable(List.generate(events2.length, (index) => index),
            key: (i) {
              return dates[i];
            },
            value: (i) => events2[i][dates[i]]);
    print(k);
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: FunctionUtils().getHashCode,
    )..addAll(k);
    print("added successfully");
  }

  Future readFile() async {
    String s = await file.readAsString();
    print(s);
  }

  @override
  void initState() {
    super.initState();
    readFile();
    getEventData(Auth().getCurrentUser().uid);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Future setEvents() async {
    List temp = await FunctionUtils().eventUsers(emails);
    int today = FunctionUtils().calculateDifference(_selectedDay);
    if (today < 0) {
      showSimpleNotification(Text("You cannot create a event before today!"));
    } else {
      for (int i = 0; i < temp.length; i++) {
        List events = [];
        print("lol");
        events.add({
          "Event": event.text,
          "description": desc.text,
          "time": timer.text,
          "CreatedBy": emails[0],
          "users": emails
        });
        final sp =
            await databaseReference.collection('Users').doc(temp[i]).get();
        String name = sp.get("Name");
        String email = sp.get("Email");
        String date = DateFormat('yyyy-MM-dd').format(_selectedDay);
        final snapShot = databaseReference
            .collection('Users')
            .doc(temp[i])
            .collection("Events")
            .doc(date);
        var data = await snapShot.get();
        int max = !data.exists ? 0 : data.get("EventList").length;
        if (max <= 3) {
          if (data.exists) {
            snapShot.update({"EventList": FieldValue.arrayUnion(events)});
            showSimpleNotification(Text("Event Added"),
                background: Color(0xff29a39d));
            FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);
          } else {
            snapShot.set({'EventList': events});
            showSimpleNotification(
                Text(
                  "Event Added",
                ),
                background: Color(0xff29a39d));
            FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);
          }
        } else {
          showSimpleNotification(
              Text(
                "$name isn't available",
              ),
              background: Color(0xff29a39d));
          break;
        }
      }
    }
  }

  Future<String> showPicker(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (BuildContext context, Widget child) {
          return child;
        });
    String res = t.format(context);
    return res;
  }

  void _tapEvents(Event e, int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(tapTitles[i]), actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (i == 0) {
                  List users = await FunctionUtils().eventUsers(e.users);
                  print(users);
                  Map temp = {
                    "CreatedBy": e.creator,
                    "Event": e.title,
                    "description": e.desc,
                    "time": e.timer,
                    "users": e.users
                  };
                  for (int i = 0; i < users.length; i++) {
                    final snapshot = databaseReference
                        .collection('Users')
                        .doc(users[i])
                        .collection("Events")
                        .doc(DateFormat('yyyy-MM-dd').format(_selectedDay));
                    await snapshot.get().then((value) {
                      List events = value.data()["EventList"];
                      print(events);
                      events.removeWhere((element) {
                        if (element["time"] == temp["time"]) {
                          return true;
                        }
                        return false;
                      });
                      print(events);
                      snapshot.update({"EventList": events});
                    });
                  }

                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new MainPage();
                  }));
                } else {
                  for (int i = 0; i < e.users.length; i++) {
                    FunctionUtils().sendEmail(
                        e.users[i],
                        DateFormat('yyyy-MM-dd').format(_selectedDay),
                        e.timer,
                        e.creator);
                  }
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new MainPage();
                  }));
                }
              },
              child: const Text('Yes'),
            ),
          ]);
        });
  }

  static const _actionTitle = 'Add Event';
  void _showAction(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_actionTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IgnorePointer(
                  child: MyTextFieldDatePicker(
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    firstDate: kFirstDay,
                    lastDate: kLastDay,
                    initialDate: _selectedDay,
                    onDateChanged: (DateTime value) {
                      if (mounted)
                        setState(() {
                          eventDate = value;
                        });
                      print(eventDate);
                    },
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  onTap: () {
                    setState(() {
                      showPicker(context).then((value) => timer.text = value);
                    });
                  },
                  controller: timer,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.timer_rounded),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      labelText: "Time",
                      hintText: "Enter Time"),
                ),
                SizedBox(height: 7),
                buildTextField(controller: event, hint: 'Event'),
                SizedBox(height: 7),
                buildTextField(controller: desc, hint: 'Description'),

                //SizedBox( height: 8),

                /*TextField(
                       controller: event,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: "Event",
                           hintText: "Enter Event Name"
                       ),
                     ),
                     //SizedBox( height: 8),
                     TextField(
                       controller: desc,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: "Description",
                           hintText: "Enter Event Description"
                       ),
                     ),*/
                //SizedBox( height: 8),
                Container(
                    child: EmailInput(
                  parentEmails: emails,
                  setList: (e) {
                    setState(() {
                      emails = e;
                    });
                  },
                ))
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                event.clear();
                desc.clear();
                timer.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (timer.text.isEmpty ||
                    !(time_12H.hasMatch(timer.text) ||
                        time_24H.hasMatch(timer.text))) {
                  showSimpleNotification(
                      Text("Please enter a valid time to the event"));
                } else if (event.text.isEmpty) {
                  showSimpleNotification(
                      Text("Please enter a valid title to the event"));
                } else if (desc.text.isEmpty) {
                  showSimpleNotification(
                      Text("Please enter description to the event"));
                } else {
                  print(emails);
                  setEvents().whenComplete(() {
                    event.clear();
                    desc.clear();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(
      {String hint, @required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => null,
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                
                Container(
                  child: 
                  
                      Text(
                        "Hi, ${Auth().getCurrentUser().displayName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700]
                        ),
                      ),
                    
                 
                ),
                Divider(
                  thickness: 2,
                ),
                TableCalendar(
                  // default view when displayed
                  // default is Saturday & Sunday but can be set to any day.
                  // instead of day number can be mentioned as well.
                  weekendDays: [DateTime.sunday, 6],
                  // default is Sunday but can be changed according to locale
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  // height between the day row and 1st date row, default is 16.0
                  daysOfWeekHeight: 30.0,
                  // height between the date rows, default is 52.0
                  rowHeight: 50.0,
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  daysOfWeekVisible: true,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  /*calendarBuilders: CalendarBuilders(
                    /*singleMarkerBuilder: (context,DateTime t ,Event f){
                      return Container(
                        decoration: new BoxDecoration(
                          color: const Color(0xff082649),
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width/150),
                        width: width / 80,
                        height: width / 80,
                      );
                    },*/
                    todayBuilder:  (context,DateTime t ,DateTime f){
                      return Container(
                        decoration: new BoxDecoration(
                          color: Colors.yellow[50],
                      shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.all(width / 100),
                        width: width / 11,
                        height: width / 11,
                        child: Center(
                          child: Text(
                            '${t.day}' ,style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context,DateTime t ,DateTime f){
                      return Container(
                        decoration: new BoxDecoration(
                            color: Colors.blue[50],
                      shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.all(width / 100),
                        width: width / 11,
                        height: width / 11,
                        child: Center(
                          child: Text(
                            '${t.day}', style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      );
                    }
                  ),*/
                  eventLoader: _getEventsForDay,

                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: true,
                    // Weekend dates color (Sat & Sun Column)
                    weekendTextStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    // highlighted color for today
                    todayDecoration: BoxDecoration(
                      color: Colors.yellow[50],
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    todayTextStyle: TextStyle(color: Colors.grey[700]),
                    // highlighted color for selected day
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.blue),
                    markerDecoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    formatButtonShowsNext: false,
                    titleTextStyle:
                        TextStyle(color: Colors.blue, fontSize: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    formatButtonTextStyle:
                        TextStyle(color: Colors.white, fontSize: 12.0),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                    leftChevronPadding: EdgeInsets.all(5),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                    rightChevronPadding: EdgeInsets.all(5),
                  ),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onLongPress: () {
                                if (value[index].creator == emails[0]) {
                                  _tapEvents(value[index], 0);
                                } else {
                                  showSimpleNotification(
                                      Text(
                                          "You can't delete event since you aren't the owner of it"),
                                      background: Color(0xff29a39d));
                                }
                              },
                              onTap: () {
                                if (value[index].creator == emails[0]) {
                                  _tapEvents(value[index], 1);
                                } else {
                                  showSimpleNotification(
                                      Text(
                                          "You can't send reminders since you didn't create the event"),
                                      background: Color(0xff29a39d));
                                }
                              },
                              leading: Text('\n' +
                                value[index].timer,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              isThreeLine: false,
                              //leading: Text((index+1).toString(),style: TextStyle(color: Colors.blue),),
                              title: Text(
                                '${value[index].title}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                value[index].desc,
                                style: TextStyle(color: Colors.blue),
                              ),
                              //trailing: Text(value[index].timer,style: TextStyle(color: Colors.blue),),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 5,
            bottom: 80,
            child: ElevatedButton(
              onPressed: () => _showAction(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, //background
                onPrimary: Colors.blue,
                //foreground
                shape: CircleBorder(),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              //capture the success flag with async and await
            ),
          ),
        ]),
      ),
    );
  }
}

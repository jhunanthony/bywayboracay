import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/pages/MainPage.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/itineraryMap.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/WeatherWidgets/weather_forecast.dart';
import 'package:bywayborcay/widgets/WeatherWidgets/weather_mainwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'auth.dart';
import 'datepicker.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarPage> {
  //map controller
  Completer<GoogleMapController> googlemapcontroller = Completer();

  List<String> emails = [Auth().getCurrentUser().email];
  LinkedHashMap kEvents = LinkedHashMap();
  ValueNotifier<List<Event>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  List<Map<DateTime, List<Event>>> events2 = [];
  TextEditingController event = TextEditingController();
  TextEditingController timer = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController website = TextEditingController();
  String imgName;
  String lat;
  String long;
  String category;

  LocationData currentLocationref;
  LocationData destinationLocationref;

  // wrapper around the location API
  Location locationref;

  //awaits weather report
  Future<WeatherInfo> futureWeather;

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
  DateTime eventDate;
  Map res = Map();

  //GET EVENTS
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
                temp[index]["budget"],
                temp[index]["website"],
                temp[index]["imgName"],
                temp[index]["lat"],
                temp[index]["long"],
                temp[index]["category"],
                temp[index]["CreatedBy"]))
      });

      //events2.sort((a,b) => a.compareTo(b));
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
    futureWeather = fetchWeather();

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    // create an instance of Location
    locationref = new Location();

    locationref.onLocationChanged.listen((LocationData cLoc) {
      locationref.enableBackgroundMode(enable: true);

      currentLocationref = cLoc;
    });

    //instantiate the polyline reference to call API

    //set up initial Locations & invoke the method
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  //get events for the day
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

  //save event in firebase

  Future setEvents() async {
    List temp = await FunctionUtils().eventUsers(emails);
    int today = FunctionUtils().calculateDifference(_selectedDay);
    if (today < 0) {
      showSimpleNotification(Text("You cannot create a event before today!"),
          position: NotificationPosition.bottom, background: Colors.white);
    } else {
      for (int i = 0; i < temp.length; i++) {
        List events = [];
        print("lol");
        events.add({
          "Event": event.text,
          "description": desc.text,
          "time": timer.text,
          "budget": budget.text,
          "website": website.text,
          "imgName": imgName,
          "lat": lat,
          "long": long,
          "category": category,
          "CreatedBy": emails[0],
          "users": emails
        });
        final sp =
            await databaseReference.collection('Users').doc(temp[i]).get();
        String name = sp.get("Name");
        String date = DateFormat('yyyy-MM-dd').format(_selectedDay);
        final snapShot = databaseReference
            .collection('Users')
            .doc(temp[i])
            .collection("Events")
            .doc(date);
        var data = await snapShot.get();
        int max = !data.exists ? 0 : data.get("EventList").length;
        if (max <= 50) {
          if (data.exists) {
            snapShot.update({"EventList": FieldValue.arrayUnion(events)});
            showSimpleNotification(
              Text("Event Added", style: TextStyle(color: Colors.blue)),
              background: Colors.white,
              position: NotificationPosition.bottom,
            );

            /*FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);*/
          } else {
            snapShot.set({'EventList': events});
            showSimpleNotification(
              Text("Event Added", style: TextStyle(color: Colors.blue)),
              background: Colors.white,
              position: NotificationPosition.bottom,
            );
            /*FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);*/
          }
        } else {
          showSimpleNotification(
            Text(
              "$name isn't available",
            ),
            background: Colors.white,
            position: NotificationPosition.bottom,
          );
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

//delete event
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
                    "budget": e.budget,
                    "website": e.website,
                    "imgName": e.imgName,
                    "lat": e.lat,
                    "long": e.long,
                    "category": e.category,
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
                      //delete items if same title, time, description
                      events.removeWhere((element) {
                        if (element["Event"] == temp["Event"] &&
                            element["time"] == temp["time"] &&
                            element["description"] == temp["description"]) {
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
                    return new MainPage(currentIndex: 1);
                  }));
                } else {
                  /*for (int i = 0; i < e.users.length; i++) {
                    FunctionUtils().sendEmail(
                        e.users[i],
                        DateFormat('yyyy-MM-dd').format(_selectedDay),
                        e.timer,
                        e.creator);
                  }*/
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new MainPage(
                      currentIndex: 1,
                    );
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
                SizedBox(height: 7),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  controller: budget,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Budget',
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
                ),
                SizedBox(height: 7),
                buildTextField(controller: website, hint: 'Website'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                event.clear();
                desc.clear();
                timer.clear();
                budget.clear();
                website.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                imgName =
                    "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2FHighlight2.jpg?alt=media&token=4d9d4510-3450-4bf8-92ea-8dddc68ba312";
                lat = "0.00";
                long = "0.00";
                category = "none";
                if (timer.text.isEmpty ||
                    !(time_12H.hasMatch(timer.text) ||
                        time_24H.hasMatch(timer.text))) {
                  showSimpleNotification(
                      Text("Please enter a valid time to the event"));
                } else if (event.text.isEmpty) {
                  showSimpleNotification(
                      Text("Please enter a valid title to the event"));
                } else if (desc.text.isEmpty) {
                  desc.text = 'No Description';
                } else if (budget.text.isEmpty) {
                  budget.text = '0.00';
                } else if (website.text.isEmpty) {
                  website.text = 'No Website Linked';
                } else {
                  print(emails);
                  setEvents().whenComplete(() {
                    event.clear();
                    desc.clear();
                    budget.clear();
                    website.clear();
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new MainPage(
                        currentIndex: 1,
                      );
                    }));
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
    return Consumer<LoginService>(builder: (context, loginService, child) {
      if (loginService.isUserLoggedIn()) {
        //if logged
        return WillPopScope(
          onWillPop: () async => null,
          child: Scaffold(
            body: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),

                    //display weather
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: FutureBuilder<WeatherInfo>(
                          future: futureWeather,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return WeatherMainWidget(
                                location: snapshot.data.location,
                                temp: snapshot.data.temp,
                                tempMin: snapshot.data.tempMin,
                                tempMax: snapshot.data.tempMax,
                                weather: snapshot.data.weather,
                                humidity: snapshot.data.humidity,
                                windspeed: snapshot.data.windspeed,
                                visibility: snapshot.data.visibility,
                                airpressure: snapshot.data.airpressure,
                                weathericon: snapshot.data.weathericon,
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"));
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TableCalendar(
                      // instead of day number can be mentioned as well.
                      weekendDays: [DateTime.sunday, 6],
                      // default is Sunday but can be changed according to locale
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      // height between the day row and 1st date row, default is 16.0
                      daysOfWeekHeight: 35.0,
                      // height between the date rows, default is 52.0
                      rowHeight: 40.0,

                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      daysOfWeekVisible: true,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,

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
                        markerSize: 3.00,
                        markersMaxCount: 8,
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
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Events",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300),
                            ),
                            Row(
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Icon(Icons.notifications_off_rounded,
                                        size: 25, color: Colors.yellow[800]),
                                    onTap: () {
                                      cancelScheduledNotifications();
                                      AwesomeNotifications()
                                          .createdStream
                                          .listen((notification) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Text(
                                                'Cancelled All Notifications',
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                          ),
                                        );
                                      });
                                    }),
                                SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue, //background
                                      onPrimary: Colors.white, //foreground
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'add event',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  onPressed: () => _showAction(
                                      context), // on press animate to 6 th element
                                ),
                              ],
                            )
                          ]),
                    ),
                    const SizedBox(height: 8.0),

                    //list of events here
                    Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          double maintotal = 0.00;
                          List<Event> markerlist = [];

                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              if (value.length > 0) {
                                value.forEach((Event value) {
                                  double total = double.parse(value.budget);

                                  maintotal += total;

                                  if (value.lat != "0.00") {
                                    markerlist.add(Event(
                                      value.title,
                                      [
                                        {
                                          "${Auth().getCurrentUser().displayName}"
                                        }
                                      ],
                                      value.desc,
                                      value.timer,
                                      value.budget,
                                      value.website,
                                      value.imgName,
                                      value.lat,
                                      value.long,
                                      value.category,
                                      "${Auth().getCurrentUser().displayName}",
                                    ));
                                  }
                                });
                              }

                              return Visibility(
                                visible: value[index].title != "sourcemarker",
                                child: Column(children: [
                                  Visibility(
                                    visible: index == 0,
                                    child: Text(
                                      "Budget for today ₱${maintotal.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            offset: Offset(2, 2)),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          value[index].imgName,
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),

                                      /*color: Colors.yellow[50],*/
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Container(
                                              decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.center,
                                              colors: <Color>[
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.3),
                                                Colors.black.withOpacity(0.5),
                                                Colors.black.withOpacity(0.7),
                                              ],
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 15,
                                              right: 15),
                                          child: Row(children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                    //notification
                                                    onTap: () async {
                                                      DateTime dateTime =
                                                          DateFormat("h:mm a")
                                                              .parse(
                                                                  value[index]
                                                                      .timer);
                                                      TimeOfDay timeOfDay =
                                                          TimeOfDay
                                                              .fromDateTime(
                                                                  dateTime);

                                                      await AwesomeNotifications()
                                                          .createNotification(
                                                              content:
                                                                  NotificationContent(
                                                                id: createUniqueID(
                                                                    AwesomeNotifications
                                                                        .maxID),
                                                                channelKey:
                                                                    'scheduled_channel',
                                                                title:
                                                                    '${Emojis.geographic_beach_with_umbrella} You have a scheduled event today!!!',
                                                                body:
                                                                    '${value[index].title} • ${DateFormat('yyyy-MM-dd').format(_selectedDay)} • ${value[index].timer}',
                                                                bigPicture:
                                                                    'asset://assets/images/Reminder.png',
                                                                notificationLayout:
                                                                    NotificationLayout
                                                                        .BigPicture,
                                                              ),
                                                              actionButtons: [
                                                                NotificationActionButton(
                                                                  key:
                                                                      'MARK_DONE',
                                                                  label:
                                                                      'Mark Done',
                                                                )
                                                              ],
                                                              schedule:
                                                                  NotificationCalendar(
                                                                weekday:
                                                                    _selectedDay
                                                                        .weekday,
                                                                day:
                                                                    _selectedDay
                                                                        .day,
                                                                month:
                                                                    _selectedDay
                                                                        .month,
                                                                year:
                                                                    _selectedDay
                                                                        .year,
                                                                hour: timeOfDay
                                                                    .hour,
                                                                minute:
                                                                    timeOfDay
                                                                        .minute,
                                                                second: 0,
                                                                millisecond: 0,
                                                              ));
                                                      //initiate notification
                                                      AwesomeNotifications()
                                                          .createdStream
                                                          .listen(
                                                              (notification) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: Text(
                                                                'Notification Created for ${value[index].title}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                          ),
                                                        );
                                                      });
                                                      //for badge dot if have notification
                                                      AwesomeNotifications()
                                                          .actionStream
                                                          .listen(
                                                              (notification) {});
                                                    },
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Icon(
                                                        Icons
                                                            .notifications_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: value[index]
                                                                .category ==
                                                            "ToStay"
                                                        ? Colors.purple[400]
                                                        : value[index]
                                                                    .category ==
                                                                "ToEat&Drink"
                                                            ? Colors.red[400]
                                                            : value[index]
                                                                        .category ==
                                                                    "ToSee"
                                                                ? Colors
                                                                    .blue[400]
                                                                : value[index]
                                                                            .category ==
                                                                        "ToDo"
                                                                    ? Colors.green[
                                                                        400]
                                                                    : Colors
                                                                        .blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Text(
                                                    "${value[index].timer}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),

                                            //leading: Text((index+1).toString(),style: TextStyle(color: Colors.blue),),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${value[index].title}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${value[index].desc}',
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        overflow:
                                                            TextOverflow.fade,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "₱${value[index].budget}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),

                                            Column(
                                              // space between two icons

                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (value[index].creator ==
                                                        emails[0]) {
                                                      _tapEvents(
                                                          value[index], 0);
                                                    } else {
                                                      showSimpleNotification(
                                                        Text(
                                                            "You can't delete event since you aren't the owner of it"),
                                                        background:
                                                            Colors.white,
                                                        position:
                                                            NotificationPosition
                                                                .bottom,
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                      Icons.highlight_off,
                                                      color: Colors.red[300]),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                Visibility(
                                                  visible:
                                                      value[index].website !=
                                                          "No Website Linked",
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (await canLaunch(
                                                          value[index]
                                                              .website)) {
                                                        await launch(
                                                            value[index]
                                                                .website);
                                                      } else {
                                                        throw SnackBar(
                                                            content: Text(
                                                                'Could not launch ${value[index].website}'));
                                                      }
                                                    },
                                                    child: Icon(
                                                        value[index]
                                                                .website
                                                                .contains(
                                                                    'www.google.com/maps/search')
                                                            ? Icons
                                                                .location_on_rounded
                                                            : CupertinoIcons
                                                                .globe,
                                                        color: Colors.white),
                                                  ),
                                                ), // icon-1
                                                SizedBox(
                                                  height: 10,
                                                ),

                                                //show map items

                                                Visibility(
                                                  visible: value[index].lat !=
                                                          "0.00" &&
                                                      value[index].long !=
                                                          "0.00",
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      LatLng dest = LatLng(
                                                          double.parse(
                                                              value[index].lat),
                                                          double.parse(
                                                              value[index]
                                                                  .long));
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ItineraryMap(
                                                                    markerlist:
                                                                        markerlist,
                                                                        dest: dest,
                                                                      category:  value[index]
                                                                  .category,
                                                                  imgName: value[index]
                                                                  .imgName,
                                                                  name: value[index]
                                                                  .title,
                                                                  timer: value[index]
                                                                  .timer,
                                                                  budget: value[index]
                                                                  .budget,


                                                                  )));
                                                      /*currentLocationref =
                                                          await locationref
                                                              .getLocation();
                                                      //insert new dummy record for user marker
                                                      markerlist.insert(
                                                          0,
                                                          Event(
                                                            "sourcemarker",
                                                            [
                                                              {"user"}
                                                            ],
                                                            "source",
                                                            "12:00",
                                                            "0.00",
                                                            "No Website Linked",
                                                            "none",
                                                            currentLocationref
                                                                .latitude
                                                                .toString(),
                                                            currentLocationref
                                                                .longitude
                                                                .toString(),
                                                            "none",
                                                            "user",
                                                          ));

                                                      //load markers
                                                      BitmapDescriptor
                                                          tostaymarker =
                                                          await BitmapDescriptor
                                                              .fromAssetImage(
                                                                  ImageConfiguration(
                                                                      devicePixelRatio:
                                                                          0.2),
                                                                  'assets/images/ToStay.png');
                                                      BitmapDescriptor
                                                          toeatdrinkmarker =
                                                          await BitmapDescriptor
                                                              .fromAssetImage(
                                                                  ImageConfiguration(
                                                                      devicePixelRatio:
                                                                          0.2),
                                                                  'assets/images/ToEat&Drink.png');
                                                      BitmapDescriptor
                                                          toseemarker =
                                                          await BitmapDescriptor
                                                              .fromAssetImage(
                                                                  ImageConfiguration(
                                                                      devicePixelRatio:
                                                                          0.2),
                                                                  'assets/images/ToSee.png');
                                                      BitmapDescriptor
                                                          todomarker =
                                                          await BitmapDescriptor
                                                              .fromAssetImage(
                                                                  ImageConfiguration(
                                                                      devicePixelRatio:
                                                                          0.2),
                                                                  'assets/images/ToDo.png');
                                                      BitmapDescriptor
                                                          usermarker =
                                                          await BitmapDescriptor
                                                              .fromAssetImage(
                                                                  ImageConfiguration(
                                                                      devicePixelRatio:
                                                                          0.2),
                                                                  'assets/images/User_Location_Marker.png');

                                                      showDialog<void>(
                                                          context: context,
                                                          builder: (context) {
                                                            Iterable _markers =
                                                                Iterable.generate(
                                                                    markerlist
                                                                        .length,
                                                                    (index) {
                                                              return Marker(
                                                                  markerId: MarkerId(
                                                                      markerlist[
                                                                              index]
                                                                          .lat),
                                                                  position:
                                                                      LatLng(
                                                                    double.parse(
                                                                        markerlist[index]
                                                                            .lat),
                                                                    double.parse(
                                                                        markerlist[index]
                                                                            .long),
                                                                  ),
                                                                  infoWindow: InfoWindow(
                                                                      title: (index)
                                                                              .toString() +
                                                                          ' • ' +
                                                                          markerlist[index]
                                                                              .title),
                                                                  icon: markerlist[index]
                                                                              .category ==
                                                                          "ToStay"
                                                                      ? tostaymarker
                                                                      : markerlist[index].category ==
                                                                              "ToEat&Drink"
                                                                          ? toeatdrinkmarker
                                                                          : markerlist[index].category == "ToDo"
                                                                              ? todomarker
                                                                              : markerlist[index].category == "ToSee"
                                                                                  ? toseemarker
                                                                                  : markerlist[index].title == "sourcemarker"
                                                                                      ? usermarker
                                                                                      : BitmapDescriptor.defaultMarkerWithHue(200));
                                                              //
                                                            });

                                                           

                                                            return AlertDialog(
                                                                title: Text(
                                                                    "Itinerary Map"),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                content: Stack(
                                                                  children: [
                                                                    Positioned
                                                                        .fill(
                                                                      child:
                                                                          GoogleMap(
                                                                        myLocationEnabled:
                                                                            true,
                                                                        mapType:
                                                                            MapType.normal,
                                                                        initialCameraPosition:
                                                                            CameraPosition(
                                                                          target: LatLng(
                                                                              double.parse(value[index].lat),
                                                                              double.parse(value[index].long)),
                                                                          zoom:
                                                                              18,
                                                                        ),
                                                                        onMapCreated:
                                                                            (GoogleMapController
                                                                                controller) {
                                                                          googlemapcontroller
                                                                              .complete(controller);
                                                                          
                                                                        },
                                                                        markers:
                                                                            Set.from(_markers),
                                                                      
                                                                      ),
                                                                    ),
                                                                    
                                                                  ],
                                                                ));
                                                          });*/
                                                    },
                                                    child: Icon(
                                                        Icons
                                                            .location_on_rounded,
                                                        color: Colors.white),
                                                  ),
                                                ),

                                                //remove item from list
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      }

      //if not logged
      return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(
                  children: [
                    SizedBox(height: 80),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset(
                        'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                        color: Colors.grey[800],
                        height: 14,
                        width: 14,
                      ),
                      Text(
                        " Itineray",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w300),
                      )
                    ]),
                  ],
                ),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset(
                        'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                        color: Colors.grey[700],
                        height: 25,
                        width: 25,
                      ),
                      Text(' Login and Start Planning!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
                    ]),
                    SizedBox(height: 305),
                  ],
                )
              ])));
    });
  }

  //Future<void> createBywayNotification() async {}

  int createUniqueID(int maxValue) {
    Random random = new Random();
    return random.nextInt(maxValue);
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}

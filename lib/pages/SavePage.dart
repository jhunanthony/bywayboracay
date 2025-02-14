import 'dart:async';


import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/SavedItemModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';

import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:bywayborcay/widgets/CalendarWidget/datepicker.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  @override
  State<SavedPage> createState() => _SavedPageState();

  static const _actionTitle = 'Add Event';
}

class _SavedPageState extends State<SavedPage> {
  Completer<GoogleMapController> googlemapcontroller = Completer();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.962116499999999, 121.92994489999998),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    //fetch user data with login service

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;

    String userName = userModel != null ? userModel.displayName : 'User';

    //import like service provider

    SaveService likeService = Provider.of<SaveService>(context, listen: false);

    //bool if a user is currently logged in

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: Column(children: [
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            'assets/icons/' + AppIcons.LikesIcon + '.svg',
            color: Colors.blue,
            height: 30,
            width: 30,
          ),
          Text(
            " Saved Items",
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue[100],
                fontWeight: FontWeight.w300),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Consumer<SaveService>(
            //a function called when notifier changes
            builder: (context, like, child) {
              List<Widget> likeditems = [];
              List<Map<String, dynamic>> markerlist = [];

              double mainTotal = 0;

              if (like.items.length > 0) {
                like.items.forEach((SavedItem item) {
                  Items itemslistinfo = (item.category as Items);

                  double total = itemslistinfo.itempriceMin;
                  mainTotal += total;

                  markerlist.add({
                    "lat": itemslistinfo.itemlat,
                    "long": itemslistinfo.itemlong,
                    "name": itemslistinfo.name,
                    "cat": itemslistinfo.itemcategoryName,
                    "subcat": itemslistinfo.itemsubcategoryName,
                    "station": itemslistinfo.itemstation,
                  });

                  likeditems.add(
                    //for each item create a container to hold the values

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: itemslistinfo.itemcategoryName == "ToStay"
                                  ? Colors.purple[100]
                                  : itemslistinfo.itemcategoryName ==
                                          "ToEat&Drink"
                                      ? Colors.red[100]
                                      : itemslistinfo.itemcategoryName ==
                                              "ToSee"
                                          ? Colors.blue[100]
                                          : itemslistinfo.itemcategoryName ==
                                                  "ToDo"
                                              ? Colors.green[100]
                                              : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset.zero)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                children: [
                                  ClipOval(
                                      child: Image.network(
                                          itemslistinfo.imgName,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover)),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CategoryIcon(
                                        color: itemslistinfo.color,
                                        iconName:
                                            itemslistinfo.itemcategoryName,
                                        size: 20,
                                      )),
                                ],
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemslistinfo.name,
                                      style: TextStyle(
                                          color: itemslistinfo
                                                      .itemcategoryName ==
                                                  "ToStay"
                                              ? Colors.purple[400]
                                              : itemslistinfo
                                                          .itemcategoryName ==
                                                      "ToEat&Drink"
                                                  ? Colors.red[400]
                                                  : itemslistinfo
                                                              .itemcategoryName ==
                                                          "ToSee"
                                                      ? Colors.blue[400]
                                                      : itemslistinfo
                                                                  .itemcategoryName ==
                                                              "ToDo"
                                                          ? Colors.green[400]
                                                          : Colors.grey[400],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      itemslistinfo.itemaddress,
                                      style: TextStyle(
                                        color: itemslistinfo.itemcategoryName ==
                                                "ToStay"
                                            ? Colors.purple[400]
                                            : itemslistinfo.itemcategoryName ==
                                                    "ToEat&Drink"
                                                ? Colors.red[400]
                                                : itemslistinfo
                                                            .itemcategoryName ==
                                                        "ToSee"
                                                    ? Colors.blue[400]
                                                    : itemslistinfo
                                                                .itemcategoryName ==
                                                            "ToDo"
                                                        ? Colors.green[400]
                                                        : Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '₱ ' +
                                          itemslistinfo.itempriceMin
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                        color: itemslistinfo.itemcategoryName ==
                                                "ToStay"
                                            ? Colors.purple[400]
                                            : itemslistinfo.itemcategoryName ==
                                                    "ToEat&Drink"
                                                ? Colors.red[400]
                                                : itemslistinfo
                                                            .itemcategoryName ==
                                                        "ToSee"
                                                    ? Colors.blue[400]
                                                    : itemslistinfo
                                                                .itemcategoryName ==
                                                            "ToDo"
                                                        ? Colors.green[400]
                                                        : Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      Icons.highlight_off,
                                      color: Colors.red[400],
                                      size: 25,
                                    ),
                                    onTap: () {
                                      like.remove(
                                          context, item, itemslistinfo.imgName);
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      CupertinoIcons.calendar,
                                      color: Colors.blue[400],
                                      size: 25,
                                    ),
                                    onTap: () => _showAction(item),
                                  ),

                                  /*GestureDetector(
                                      onTap: () async {
                                        BitmapDescriptor destinationIcon =
                                            await BitmapDescriptor
                                                .fromAssetImage(
                                                    ImageConfiguration(
                                                        devicePixelRatio: 0.2),
                                                    'assets/images/' +
                                                        itemslistinfo
                                                            .itemcategoryName +
                                                        '.png');
                                        showDialog<void>(
                                            context: context,
                                            builder: (context) {
                                              Iterable _markers =
                                                  Iterable.generate(
                                                      likeditems.length,
                                                      (index) {
                                                return Marker(
                                                    markerId: MarkerId(
                                                        itemslistinfo.name),
                                                    position: LatLng(
                                                        itemslistinfo.itemlat,
                                                        itemslistinfo.itemlong),
                                                    infoWindow: InfoWindow(
                                                        title:
                                                            itemslistinfo.name),
                                                    icon: destinationIcon);
                                                //
                                              });

                                              return AlertDialog(
                                                  title: Text("Map Search"),
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  content: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: GoogleMap(
                                                          myLocationEnabled:
                                                              true,
                                                          mapType:
                                                              MapType.normal,
                                                          initialCameraPosition:
                                                              _kGooglePlex,
                                                          onMapCreated:
                                                              (GoogleMapController
                                                                  controller) {
                                                            googlemapcontroller
                                                                .complete(
                                                                    controller);
                                                          },
                                                          markers: Set.from(
                                                              _markers),
                                                        ),
                                                      )
                                                    ],
                                                  ));
                                            });
                                      },
                                      child: Icon(
                                        Icons.map,
                                        size: 25,
                                        color: Colors.blue,
                                      )),*/
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background
                            onPrimary: Colors.blue,
                            //foreground
                            shape: CircleBorder(),
                          ),

                          child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.map_rounded,
                                  size: 25, color: Colors.blue)),
                          //capture the success flag with async and await
                          onPressed: () async {
                            BitmapDescriptor tostaymarker =
                                await BitmapDescriptor.fromAssetImage(
                                    ImageConfiguration(devicePixelRatio: 0.2),
                                    'assets/images/ToStay.png');
                            BitmapDescriptor toeatdrinkmarker =
                                await BitmapDescriptor.fromAssetImage(
                                    ImageConfiguration(devicePixelRatio: 0.2),
                                    'assets/images/ToEat&Drink.png');
                            BitmapDescriptor toseemarker =
                                await BitmapDescriptor.fromAssetImage(
                                    ImageConfiguration(devicePixelRatio: 0.2),
                                    'assets/images/ToSee.png');
                            BitmapDescriptor todomarker =
                                await BitmapDescriptor.fromAssetImage(
                                    ImageConfiguration(devicePixelRatio: 0.2),
                                    'assets/images/ToDo.png');

                            Iterable _onemarkers =
                                Iterable.generate(likeditems.length, (index) {
                              return Marker(
                                  markerId: MarkerId(markerlist[index]['name']),
                                  position: LatLng(markerlist[index]['lat'],
                                      markerlist[index]['long']),
                                  infoWindow: InfoWindow(
                                      title: markerlist[index]['name'],
                                      snippet: markerlist[index]['subcat'] +
                                          ", Station " +
                                          markerlist[index]['station'],
                                      onTap: () {}),
                                  icon: markerlist[index]['cat'] == "ToStay"
                                      ? tostaymarker
                                      : markerlist[index]['cat'] ==
                                              "ToEat&Drink"
                                          ? toeatdrinkmarker
                                          : markerlist[index]['cat'] == "ToDo"
                                              ? todomarker
                                              : markerlist[index]['cat'] ==
                                                      "ToSee"
                                                  ? toseemarker
                                                  : BitmapDescriptor
                                                      .defaultMarkerWithHue(
                                                          200));
                            });

                            showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text("Map Search"),
                                      contentPadding: EdgeInsets.only(
                                          top: 10,
                                          right: 0,
                                          left: 0,
                                          bottom: 10),
                                      content: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: GoogleMap(
                                              myLocationEnabled: true,
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  _kGooglePlex,
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                googlemapcontroller
                                                    .complete(controller);
                                              },
                                              markers: Set.from(_onemarkers),
                                            ),
                                          )
                                        ],
                                      ));
                                });
                          },
                        ),
                        SizedBox(width: 5),
                        Consumer<SaveService>(builder: (context, like, child) {
                          if (like.items.length > 0) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, //background
                                onPrimary: Colors.blue,
                                //foreground
                              ),
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_rounded,
                                          size: 25, color: Colors.blue),
                                      Text(" Delete All ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                              //capture the success flag with async and await
                              onPressed: () => likeService.removeAll(context),
                            );
                          }

                          return SizedBox();
                        })
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView(
                      children: likeditems,
                    )),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(CupertinoIcons.tag,
                                color: Colors.blue, size: 14),
                            SizedBox(
                              width: 18,
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text:
                                    'Estimated Budget: ₱ ${mainTotal.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ]))
                          ],
                        ))
                  ],
                );
              } else {
                return Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.favorite_rounded,
                          size: 20, color: Colors.grey[400]),
                      Text('Explore Boracay Now!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
                    ]));
              }
            },
          ),
        ),
        SizedBox(height: 10),
      ]),

      //bottomNavigationBar: BottomNavBar(),
    );
  }

  List<String> emails = [Auth().getCurrentUser().email];
  List<Map<DateTime, List<Event>>> events2 = [];
  TextEditingController event = TextEditingController();
  TextEditingController timer = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController website = TextEditingController();
  String imgName;
  String lat;
  String long;
  String address;
  String itemname;
  String category;
  DateTime _selectedDay = DateTime.now();

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

  void _showAction(SavedItem item) {
    Items itemslistinfo = (item.category as Items);
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(10),
          title: Text(SavedPage._actionTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFieldDatePicker(
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
                TextField(
                  controller: desc,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Description',
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
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  controller: budget,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Budget from ${itemslistinfo.itempriceMin}",
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
                TextField(
                  controller: website..text = "${itemslistinfo.itemwebsite}",
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Website',
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

                //SizedBox( height: 8),
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
                imgName = itemslistinfo.imgName;
                lat = itemslistinfo.itemlat.toString();
                long = itemslistinfo.itemlong.toString();
                address = itemslistinfo.itemaddress.toString();
                itemname = itemslistinfo.name.toString();
                category = itemslistinfo.itemcategoryName;
                if (timer.text.isEmpty ||
                    !(time_12H.hasMatch(timer.text) ||
                        time_24H.hasMatch(timer.text))) {
                  showSimpleNotification(
                      Text("Please enter a valid time to the event"));
                } else if (eventDate == null) {
                  eventDate = DateTime.now();
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

  Future setEvents() async {
    List temp = await FunctionUtils().eventUsers(emails);
    int today = FunctionUtils().calculateDifference(_selectedDay);
    if (today < 0) {
      showSimpleNotification(
        Text("You cannot create a event before today!"),
        background: Colors.white,
        position: NotificationPosition.bottom,
      );
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
          "address": address,
          "itemname": itemname,
          "category": category,
          "CreatedBy": emails[0],
          "users": emails
        });
        final sp =
            await databaseReference.collection('Users').doc(temp[i]).get();
        String name = sp.get("Name");
        String email = sp.get("Email");
        String date = DateFormat('yyyy-MM-dd').format(eventDate);
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
            /* FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);*/
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
}

import 'dart:async';
import 'dart:ui';

import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/LikedItemsModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/pages/DetailsPage.dart';

import 'package:bywayborcay/services/likeservice.dart';
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

class LikedPage extends StatefulWidget {
  @override
  State<LikedPage> createState() => _LikedPageState();

  static const _actionTitle = 'Add Event';
}

class _LikedPageState extends State<LikedPage> {
  Completer<GoogleMapController> googlemapcontroller = Completer();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.962116499999999, 121.92994489999998),
    zoom: 13,
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

    LikeService likeService = Provider.of<LikeService>(context, listen: false);

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
            " Likes",
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue[100],
                fontWeight: FontWeight.w300),
          )
        ]),
        /*Set.from(
                    markers = _markers = Iterable.generate(like.items.length, (index) {
                  like.items.forEach((LikedItem item) {
                    Items itemslistinfo = (item.category as Items);
                    return Marker(
                        markerId: MarkerId(itemslistinfo.name),
                        position: LatLng(
                          itemslistinfo.itemlat,
                          itemslistinfo.itemlong,
                        ),
                        infoWindow: InfoWindow(title: itemslistinfo.name));
                  });
                })),*/
        SizedBox(
          height: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Hi $userName',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Consumer<LikeService>(
                  //a function called when notifier changes
                  builder: (context, like, child) {
                return
                    //hide if 0 likes
                    Visibility(
                  visible: like.items.length > 0,
                  child: Text(
                    'you have ${like.items.length} liked item!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[100],
                    ),
                  ),
                );
              }),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<LikeService>(builder: (context, like, child) {
                  if (like.items.length > 0) {
                    return GestureDetector(
                      onTap: () {
                        //remove all items
                        likeService.removeAll(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 20),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.blue),
                              SizedBox(width: 5),
                              Text('Delete All',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ))
                            ],
                          )),
                    );
                  }

                  return SizedBox();
                })
              ],
            ),
          ],
        ),
        Expanded(
          child: Consumer<LikeService>(
            //a function called when notifier changes
            builder: (context, like, child) {
              List<Widget> likeditems = [];
              double mainTotal = 0;
              Items itemcontain;

              if (like.items.length > 0) {
                like.items.forEach((LikedItem item) {
                  Items itemslistinfo = (item.category as Items);

                  double total = itemslistinfo.itempriceMin;
                  mainTotal += total;
                  itemcontain = itemcontain;

                  likeditems.add(
                    //for each item create a container to hold the values
                      
                    Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                    child: Image.network(itemslistinfo.imgName,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover)),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CategoryIcon(
                                      color: itemslistinfo.color,
                                      iconName: itemslistinfo.iconName,
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
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    itemslistinfo.itemaddress,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '₱ ' +
                                        itemslistinfo.itempriceMin
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.highlight_off,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    like.remove(context, item);
                                  },
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    CupertinoIcons.calendar,
                                    color: Colors.blue[200],
                                    size: 25,
                                  ),
                                  onTap: () => _showAction(item),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            )
                          ],
                        )),
                  );
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () async {
                          /*BitmapDescriptor destinationIcon =
                                          await BitmapDescriptor.fromAssetImage(
                                              ImageConfiguration(
                                                  devicePixelRatio: 0.2),
                                              'assets/images/' +
                                                  itemslistinfo.itemmarkerName +
                                                  '.png');*/
                          showDialog<void>(
                              context: context,
                              builder: (context) {
                                Iterable _markers = Iterable.generate(
                                    likeditems.length, (index) {
                                  return Marker(
                                      markerId: MarkerId(itemcontain.name),
                                      position: LatLng(itemcontain.itemlat,
                                         itemcontain.itemlat),
                                      infoWindow:
                                          InfoWindow(title: itemcontain.name),
                                      icon: BitmapDescriptor.defaultMarkerWithHue(200));
                                  //
                                });

                                return AlertDialog(
                                    title: Text("Map Search"),
                                    contentPadding: EdgeInsets.all(0),
                                    content: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: GoogleMap(
                                            myLocationEnabled: true,
                                            mapType: MapType.normal,
                                            initialCameraPosition: _kGooglePlex,
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              googlemapcontroller
                                                  .complete(controller);
                                            },
                                            markers: Set.from(_markers),
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
                        )),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(children: likeditems),
                          )),
                    ),
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
        SizedBox(height: 50),
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

  void _showAction(LikedItem item) {
    Items itemslistinfo = (item.category as Items);
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(10),
          title: Text(LikedPage._actionTitle),
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
                TextField(
                  controller: event..text = "${itemslistinfo.name}",
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Event',
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: budget
                    ..text = "${itemslistinfo.itempriceMin.toStringAsFixed(2)}",
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
                TextField(
                  controller: website
                    ..text =
                        "https://www.google.com/maps/search/?api=1&query=${itemslistinfo.itemlat},${itemslistinfo.itemlong}",
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
                  website.text = '0.00';
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
      showSimpleNotification(Text("You cannot create a event before today!"));
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
}

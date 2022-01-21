import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../services/loginservice.dart';
import '../Navigation/TopNavBar.dart';

class LinkList {
  String link;
  String name;
  LinkList(this.link, this.name);
}

class TravelList {
  String step;
  String description;
  String website;
  String index;
  TravelList(this.step, this.description, this.website, this.index);
}

class TravelGuidelines extends StatefulWidget {
  @override
  State createState() {
    return TravelGuidelinesState();
  }
}

final List<String> imgList = [
  'https://wallpaperaccess.com/full/4796681.jpg',
  'https://wallpaperaccess.com/full/1510567.jpg',
  'https://cdn.wallpapersafari.com/39/43/7jFuqv.jpg',
  'https://i.pinimg.com/736x/50/5c/88/505c889e25d389f211cc26a67c5547b7--boracay-island-phillipines.jpg',
  'https://img.traveltriangle.com/blog/wp-content/uploads/2018/04/Cover13.jpg',
  'https://i1.wp.com/amazingplacesonearth.com/wp-content/uploads/2012/08/ss.jpg?ssl=1',
];

class TravelGuidelinesState extends State<TravelGuidelines> {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    UserLogInModel userModel = loginService.loggedInUserModel;

    String uid = userModel != null ? userModel.uid : '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body:
          /* SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Icon(Icons.airplanemode_active,
                        color: Colors.blue, size: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Center(
                        child: Text('TRAVEL GUIDELINES',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25.0,
                            ))),
                  ),
                ],
              ),
            ),
            CarouselWithDotsPage(imgList: imgList),*/
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('travelguidelines')
                  .doc('steps')
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var userDocument = snapshot.data;

                  final List<TravelList> travellist = [];

                  userDocument['travelprocedures'].forEach((value) {
                    travellist.add(TravelList(
                        value['step'],
                        value['description'],
                        value['website'],
                        value['index']));
                  });

                  travellist
                    ..sort(
                        (item1, item2) => item1.index.compareTo(item2.index));

                  return travellist.length > 0
                      ? ListView.builder(
                          itemCount: travellist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              Visibility(
                                  visible: index == 0,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Icon(
                                                  Icons.airplanemode_active,
                                                  color: Colors.blue,
                                                  size: 25),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15.0),
                                              child: Center(
                                                  child:
                                                      Text('TRAVEL GUIDELINES',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 25.0,
                                                          ))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      CarouselWithDotsPage(imgList: imgList),
                                    ],
                                  )),
                              //add new step
                              Visibility(
                                  visible:
                                      uid == "x19aFGBbXBaXTZY92Al8f8UbWyX2" &&
                                          index == 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: TextButton(
                                      onPressed: () async {
                                        TextEditingController step =
                                            TextEditingController();
                                        TextEditingController description =
                                            TextEditingController();
                                        TextEditingController website =
                                            TextEditingController();
                                        TextEditingController stepindex =
                                            TextEditingController();

                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      "Admin: Add New Step",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors
                                                              .blue[400])),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        //field to comment
                                                        TextField(
                                                          controller: stepindex,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ], // Only numbers can be entered
                                                          decoration:
                                                              InputDecoration(
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            labelText:
                                                                'Step Number',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors
                                                                              .blue,
                                                                      width:
                                                                          1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          controller: step,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          decoration:
                                                              InputDecoration(
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            labelText:
                                                                'Step Index and Name',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors
                                                                              .blue,
                                                                      width:
                                                                          1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          minLines: 1,
                                                          maxLines: 20,
                                                          maxLength: 1000,
                                                          controller:
                                                              description,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          decoration:
                                                              InputDecoration(
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            labelText:
                                                                'Description',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors
                                                                              .blue,
                                                                      width:
                                                                          1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),

                                                        TextField(
                                                          controller: website,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          decoration:
                                                              InputDecoration(
                                                            labelStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            labelText:
                                                                'Link attachment',
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          Colors
                                                                              .blue,
                                                                      width:
                                                                          1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        step.clear();
                                                        description.clear();
                                                        website.clear();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'travelguidelines')
                                                            .doc('steps')
                                                            .update({
                                                          "travelprocedures":
                                                              FieldValue
                                                                  .arrayUnion([
                                                            {
                                                              "step":
                                                                  "${step.text}",
                                                              "description":
                                                                  "${description.text}",
                                                              "website":
                                                                  "${website.text}",
                                                              "index":
                                                                  "${stepindex.text}"
                                                            }
                                                          ])
                                                        });
                                                        Navigator.pop(context);
                                                        showSimpleNotification(
                                                          Text(
                                                              "New Step Added"),
                                                          background:
                                                              Colors.green[400],
                                                          position:
                                                              NotificationPosition
                                                                  .bottom,
                                                        );
                                                      },
                                                      child: Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                          color: Colors.teal,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              size: 16, color: Colors.red[400]),
                                          SizedBox(width: 5),
                                          Text('Admin: Add New Step',
                                              style: TextStyle(
                                                  color: Colors.red[400])),
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Container(
                                  color: const Color(0xffb1ebfa),
                                  child: ExpandableNotifier(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: <Widget>[
                                          ScrollOnExpand(
                                            scrollOnExpand: true,
                                            scrollOnCollapse: false,
                                            child: ExpandablePanel(
                                              theme: const ExpandableThemeData(
                                                headerAlignment:
                                                    ExpandablePanelHeaderAlignment
                                                        .center,
                                                tapBodyToCollapse: true,
                                              ),
                                              // ignore: prefer_const_constructors
                                              header: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    "Step ${travellist[index].index} : ${travellist[index].step}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              collapsed: const Text(
                                                step1,
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              expanded: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: <Widget>[
                                                    RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${travellist[index].description}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        TextSpan(
                                                            text: "Link",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () async {
                                                                    if (await canLaunch(
                                                                            "${travellist[index].website}") ==
                                                                        true) {
                                                                      launch(
                                                                          "${travellist[index].website}");
                                                                    } else {
                                                                      print(
                                                                          "Can't launch URL");
                                                                    }
                                                                  })
                                                      ]),
                                                    ),
                                                    //edit step
                                                    Visibility(
                                                      visible: uid ==
                                                          "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          TextEditingController
                                                              step =
                                                              TextEditingController();
                                                          TextEditingController
                                                              description =
                                                              TextEditingController();
                                                          TextEditingController
                                                              website =
                                                              TextEditingController();
                                                          TextEditingController
                                                              stepindex =
                                                              TextEditingController();

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: Text(
                                                                            "Admin: Edit This Step",
                                                                            style:
                                                                                TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              //field to comment
                                                                              TextField(
                                                                                controller: stepindex..text = "${travellist[index].index}",
                                                                                textCapitalization: TextCapitalization.words,
                                                                                inputFormatters: <TextInputFormatter>[
                                                                                  FilteringTextInputFormatter.digitsOnly
                                                                                ], // Only numbers can be entered
                                                                                decoration: InputDecoration(
                                                                                  labelStyle: TextStyle(color: Colors.grey),
                                                                                  labelText: 'Step Number',
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              TextField(
                                                                                controller: step..text = "${travellist[index].step}",
                                                                                textCapitalization: TextCapitalization.words,
                                                                                decoration: InputDecoration(
                                                                                  labelStyle: TextStyle(color: Colors.grey),
                                                                                  labelText: 'Step Index and Name',
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              TextField(
                                                                                keyboardType: TextInputType.multiline,
                                                                                minLines: 1,
                                                                                maxLines: 20,
                                                                                maxLength: 1000,
                                                                                controller: description..text = "${travellist[index].description}",
                                                                                textCapitalization: TextCapitalization.words,
                                                                                decoration: InputDecoration(
                                                                                  labelStyle: TextStyle(color: Colors.grey),
                                                                                  labelText: 'Description',
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),

                                                                              TextField(
                                                                                controller: website..text = "${travellist[index].website}",
                                                                                textCapitalization: TextCapitalization.words,
                                                                                decoration: InputDecoration(
                                                                                  labelStyle: TextStyle(color: Colors.grey),
                                                                                  labelText: 'Link attachment',
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              step.clear();
                                                                              description.clear();
                                                                              website.clear();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Cancel',
                                                                              style: TextStyle(color: Colors.grey, fontSize: 18),
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              FirebaseFirestore.instance.collection('travelguidelines').doc('steps').update({
                                                                                "travelprocedures": FieldValue.arrayRemove([
                                                                                  {
                                                                                    "step": "${travellist[index].step}",
                                                                                    "description": "${travellist[index].description}",
                                                                                    "website": "${travellist[index].website}",
                                                                                    "index": "${travellist[index].index}"
                                                                                  }
                                                                                ])
                                                                              });
                                                                              FirebaseFirestore.instance.collection('travelguidelines').doc('steps').update({
                                                                                "travelprocedures": FieldValue.arrayUnion([
                                                                                  {
                                                                                    "step": "${step.text}",
                                                                                    "description": "${description.text}",
                                                                                    "website": "${website.text}",
                                                                                    "index": "${stepindex.text}"
                                                                                  }
                                                                                ])
                                                                              });
                                                                              Navigator.pop(context);
                                                                              showSimpleNotification(
                                                                                Text("Step Updated"),
                                                                                background: Colors.green[400],
                                                                                position: NotificationPosition.bottom,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Submit',
                                                                              style: TextStyle(
                                                                                color: Colors.teal,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.edit,
                                                                size: 16,
                                                                color: Colors
                                                                    .red[400]),
                                                            SizedBox(width: 5),
                                                            Text(
                                                                'Admin: Edit this Step',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        400])),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    //delete step
                                                    Visibility(
                                                      visible: uid ==
                                                          "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          TextEditingController
                                                              step =
                                                              TextEditingController();
                                                          TextEditingController
                                                              description =
                                                              TextEditingController();
                                                          TextEditingController
                                                              website =
                                                              TextEditingController();
                                                          TextEditingController
                                                              stepindex =
                                                              TextEditingController();

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              //field to comment
                                                                              Text("Admin: Do you really want to delete this step?", style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              step.clear();
                                                                              description.clear();
                                                                              website.clear();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Cancel',
                                                                              style: TextStyle(color: Colors.grey, fontSize: 18),
                                                                            ),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              FirebaseFirestore.instance.collection('travelguidelines').doc('steps').update({
                                                                                "travelprocedures": FieldValue.arrayRemove([
                                                                                  {
                                                                                    "step": "${travellist[index].step}",
                                                                                    "description": "${travellist[index].description}",
                                                                                    "website": "${travellist[index].website}",
                                                                                    "index": "${travellist[index].index}"
                                                                                  }
                                                                                ])
                                                                              });

                                                                              Navigator.pop(context);
                                                                              showSimpleNotification(
                                                                                Text("Step Deleted"),
                                                                                background: Colors.green[400],
                                                                                position: NotificationPosition.bottom,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Submit',
                                                                              style: TextStyle(
                                                                                color: Colors.teal,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete,
                                                                size: 16,
                                                                color: Colors
                                                                    .red[400]),
                                                            SizedBox(width: 5),
                                                            Text(
                                                                'Admin: Delete this Step',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        400])),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              builder:
                                                  (_, collapsed, expanded) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  child: Expandable(
                                                    collapsed: collapsed,
                                                    expanded: expanded,
                                                    theme:
                                                        const ExpandableThemeData(
                                                            crossFadePoint: 0),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: index == travellist.length - 1,
                                  child: Column(
                                    children: [
                                      Card10(),
                                      Card9(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            'Disclaimer: This app contains affiliated links and contacts.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                      blurRadius: 3.0,
                                                      color: Colors.grey[900]),
                                                ],
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  )),
                            ]);
                          })
                      : travellist.length == null
                          ? SizedBox()
                          : SizedBox();
                } else if (snapshot.hasError) {
                  return Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  );
                } else
                  return Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  );
              }),

      /*Card1(),
              Card2(),
              Card3(),
              Card4(),
              Card5(),
              Card6(),
              Card7(),
              Card8(),
              Card10(),
              Card9(),*/
    );
  }
}

class CarouselWithDotsPage extends StatefulWidget {
  List<String> imgList;

  CarouselWithDotsPage({this.imgList});

  @override
  _CarouselWithDotsPageState createState() => _CarouselWithDotsPageState();
}

class _CarouselWithDotsPageState extends State<CarouselWithDotsPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(height: 200.0),
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: const [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            'Boracay Island',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.0),
        ),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

const step1 = "Read More";

var defaultText = const TextStyle(color: Colors.black);
var linkText = const TextStyle(color: Colors.blue);

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    // ignore: prefer_const_constructors
                    header: Padding(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "Step 1: Get Tested for COVID-19",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    collapsed: const Text(
                      step1,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "A strict test-before-travel policy has been put into place for unvaccinated individuals planning to visit Boracay. Before you fly, a negative RT-PCR test or Saliva Test result must be presented before you are permitted to travel. It is also important to note that the Boracay government will only accept negative RT-PCR or Saliva test results taken at most 72 hours (3 days) before departure. That said, be sure that your testing site can provide the RT-PCR/Saliva Test results within 24 hours. RT-PCR/Saliva tests must be taken only in ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "accredited laboratories",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://hfsrb.doh.gov.ph/list-of-licensed-covid-19-testing-facilities/?spm=BlogArticle.InArticleHyperlinkWord&clickId=eb2ce70d42") ==
                                          true) {
                                        launch(
                                            "https://hfsrb.doh.gov.ph/list-of-licensed-covid-19-testing-facilities/?spm=BlogArticle.InArticleHyperlinkWord&clickId=eb2ce70d42");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 2: Secure your flights to Boracay",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "In a COVID-19 free world, securing your flights would normally be the first thing you do. Though you can still do that, it is recommended to book your flights once you’ve received your negative RT-PCR/Saliva test results. When booking your flight, please note that your flight schedule should be within 72 hours from the time you took your RT-PCR/Saliva test (not when you received your results). That said, if you are able to find an accredited testing facility to provide you results in less than 24 hours, that would allow you more time to prepare for your trip. Also, be sure to  as this is the designated port of entry for tourists traveling to Boracay by air. ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "Book your flights at Caticlan Airport",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://www.klook.com/en-PH/blog/caticlan-to-boracay-island-transfers/?spm=BlogArticle.InArticleHyperlinkWord&clickId=f97b6001c4") ==
                                          true) {
                                        launch(
                                            "https://www.klook.com/en-PH/blog/caticlan-to-boracay-island-transfers/?spm=BlogArticle.InArticleHyperlinkWord&clickId=f97b6001c4");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 3: Secure Your Hotel Booking",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "Next, you will need to secure a hotel reservation at an accredited accommodation .Be sure to do this as soon as possible considering the tight time frame between receiving your test results and your departure date. The Boracay Government has released a list of accredited hotels for tourist to select from. ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "List of Accredited Hotels",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://www.myboracayguide.com/info/en/boracay-covid-2019-2020-compliant-hotels-6240.html") ==
                                          true) {
                                        launch(
                                            "https://www.myboracayguide.com/info/en/boracay-covid-2019-2020-compliant-hotels-6240.html");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class Card4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 4: Fill Out Health Declaration Form",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "This will need to be completed as part of the necessary travel requirements. Travelers will need to disclose personal information, valid ID information, details of Philippine residence, flight and hotel booking details, travel history, and itinerary. select BORACAY to access the official health declaration form. ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "Visit tourist boracay",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://www.touristboracay.com/?spm=BlogArticle.InArticleHyperlinkWord&clickId=93eef6980c") ==
                                          true) {
                                        launch(
                                            "https://www.touristboracay.com/?spm=BlogArticle.InArticleHyperlinkWord&clickId=93eef6980c");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 5: Submit your requirements via email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: const [
                              TextSpan(
                                  text:
                                      "Now that you have your negative RT-PCR/Saliva test results, flight bookings, hotel reservations and a completed health declaration form, you will need to submit copies of these via email along with a valid government-issued ID. Submit to touristboracay@gmail.com",
                                  style: TextStyle(color: Colors.black)),
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 6: Wait for your Tourist QR Code",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      " Once your requirements have been submitted, the waiting game begins!. tourists are encouraged to send both their Health Declaration Forms to tourist boracay and requirements via email at least 12 hours before their departure to avoid any delays. According to  ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "Aklan Government - Guide for Tourist",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://aklan.gov.ph/guide-for-tourists/?spm=BlogArticle.InArticleHyperlinkWord&clickId=bf56325ba3") ==
                                          true) {
                                        launch(
                                            "https://aklan.gov.ph/guide-for-tourists/?spm=BlogArticle.InArticleHyperlinkWord&clickId=bf56325ba3");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ExpandableNotifier(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 7: Pack & QUARANTINE!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: const [
                              TextSpan(
                                  text:
                                      "As soon as you get tested at any of the accredited facilities, you will immediately need to quarantine until your flight to Boracay. Avoid any other interactions with individuals outside of your household for the time being. When packing, of course be sure to pack your safety essentials: face masks, face shields, alcohol, wipes, etc. Check with your airline for any additional requirements they have for travelers.   ",
                                  style: TextStyle(color: Colors.black)),
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return Container(
        color: const Color(0xffb1ebfa),
        child: ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Step 8:Pre-book transfers and activities",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      collapsed: Text(
                        step1,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "To get to boracay island from the boracay caticlan airport, you will need to take several transfers - a bus to the port, boat to Boracay Island and a van to your accommodation. Ease the process and pre-book your  for a hassle-free arrival. ",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "Book your flights at Caticlan Airport",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (await canLaunch(
                                              "https://www.myboracayguide.com/info/en/boracay-covid-2019-2020-compliant-hotels-6240.html") ==
                                          true) {
                                        launch(
                                            "https://www.myboracayguide.com/info/en/boracay-covid-2019-2020-compliant-hotels-6240.html");
                                      } else {
                                        print("Can't launch URL");
                                      }
                                    })
                            ]),
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "3 Expandable widgets",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
              Expanded(child: buildImg(Colors.orange, 100)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: buildImg(Colors.lightBlue, 100)),
              Expanded(child: buildImg(Colors.cyan, 100)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(step1),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    UserLogInModel userModel = loginService.loggedInUserModel;

    String useruid = userModel != null ? userModel.uid : '';
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: Color(0xff0470a2),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Boracay Official Tourism Websites",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('website')
                            .doc('links')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var userDocument = snapshot.data;

                            final List<LinkList> linklist = [];

                            userDocument['linklist'].forEach((value) {
                              linklist
                                  .add(LinkList(value['link'], value['name']));
                            });
                            return linklist.length > 0
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: linklist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Visibility(
                                                    visible: useruid ==
                                                            "x19aFGBbXBaXTZY92Al8f8UbWyX2" &&
                                                        index == 0,
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        TextEditingController
                                                            link =
                                                            TextEditingController();
                                                        TextEditingController
                                                            name =
                                                            TextEditingController();

                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Admin: Add New Link",
                                                                          style: TextStyle(
                                                                              fontSize: 25,
                                                                              color: Colors.blue[400])),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            //field to comment
                                                                            TextField(
                                                                              controller: name,
                                                                              textCapitalization: TextCapitalization.words,
                                                                              decoration: InputDecoration(
                                                                                labelStyle: TextStyle(color: Colors.grey),
                                                                                labelText: 'Website Name',
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            TextField(
                                                                              controller: link,
                                                                              textCapitalization: TextCapitalization.words,
                                                                              decoration: InputDecoration(
                                                                                labelStyle: TextStyle(color: Colors.grey),
                                                                                labelText: 'Link',
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            name.clear();
                                                                            link.clear();
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontSize: 18),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            FirebaseFirestore.instance.collection('website').doc('links').update({
                                                                              "linklist": FieldValue.arrayUnion([
                                                                                {
                                                                                  "name": "${name.text}",
                                                                                  "link": "${link.text}"
                                                                                }
                                                                              ])
                                                                            });
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              Text("Review has been submitted!"),
                                                                              background: Colors.green[400],
                                                                              position: NotificationPosition.bottom,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Submit',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.teal,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ));
                                                      },
                                                      child: Text(
                                                          'Admin: Add New Official Link',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[400])),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            String url =
                                                                "${linklist[index].link}";
                                                            if (await canLaunch(
                                                                url)) {
                                                              await launch(url);
                                                            } else {
                                                              showSimpleNotification(
                                                                Text(
                                                                    "Could not lunch $url"),
                                                                background:
                                                                    Colors.green[
                                                                        400],
                                                                position:
                                                                    NotificationPosition
                                                                        .bottom,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                              '${linklist[index].name}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Visibility(
                                                              visible: useruid ==
                                                                  "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  TextEditingController
                                                                      website =
                                                                      TextEditingController();
                                                                  TextEditingController
                                                                      name =
                                                                      TextEditingController();

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                title: Text("Admin: Edit Official Links", style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      //field to comment
                                                                                      TextField(
                                                                                        controller: name..text = "${linklist[index].name}",
                                                                                        textCapitalization: TextCapitalization.words,
                                                                                        decoration: InputDecoration(
                                                                                          labelStyle: TextStyle(color: Colors.grey),
                                                                                          labelText: 'Website Name',
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      TextField(
                                                                                        controller: website..text = "${linklist[index].link}",
                                                                                        textCapitalization: TextCapitalization.words,
                                                                                        decoration: InputDecoration(
                                                                                          labelStyle: TextStyle(color: Colors.grey),
                                                                                          labelText: 'Link',
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      name.clear();
                                                                                      website.clear();
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text(
                                                                                      'Cancel',
                                                                                      style: TextStyle(color: Colors.grey, fontSize: 18),
                                                                                    ),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () async {
                                                                                      FirebaseFirestore.instance.collection('website').doc('links').update({
                                                                                        "linklist": FieldValue.arrayRemove([
                                                                                          {
                                                                                            "name": "${linklist[index].name}",
                                                                                            "link": "${linklist[index].link}"
                                                                                          }
                                                                                        ])
                                                                                      });

                                                                                      FirebaseFirestore.instance.collection('website').doc('links').update({
                                                                                        "linklist": FieldValue.arrayUnion([
                                                                                          {
                                                                                            "name": "${name.text}",
                                                                                            "link": "${website.text}"
                                                                                          }
                                                                                        ])
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                      showSimpleNotification(
                                                                                        Text("List has been edited"),
                                                                                        background: Colors.green[400],
                                                                                        position: NotificationPosition.bottom,
                                                                                      );
                                                                                    },
                                                                                    child: Text(
                                                                                      'Submit',
                                                                                      style: TextStyle(
                                                                                        color: Colors.teal,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                },
                                                                icon: Icon(
                                                                    Icons.edit,
                                                                    size: 16,
                                                                    color: Colors
                                                                            .red[
                                                                        400]),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: useruid ==
                                                                  "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      //field to comment
                                                                                      Text("Admin: Do you really want to delete this item?", style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () async {
                                                                                      FirebaseFirestore.instance.collection('website').doc('links').update({
                                                                                        "linklist": FieldValue.arrayRemove([
                                                                                          {
                                                                                            "name": "${linklist[index].name}",
                                                                                            "link": "${linklist[index].link}"
                                                                                          }
                                                                                        ])
                                                                                      });
                                                                                      Navigator.pop(context);

                                                                                      showSimpleNotification(
                                                                                        Text("Link removed"),
                                                                                        background: Colors.green[400],
                                                                                        position: NotificationPosition.bottom,
                                                                                      );
                                                                                    },
                                                                                    child: Text(
                                                                                      'Delete',
                                                                                      style: TextStyle(
                                                                                        color: Colors.teal,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                },
                                                                icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 16,
                                                                    color: Colors
                                                                            .red[
                                                                        400]),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : linklist.length == null
                                    ? SizedBox()
                                    : SizedBox();
                          } else if (snapshot.hasError) {
                            return SizedBox();
                          } else
                            return Text(
                              'Loading',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            );
                        }),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    UserLogInModel userModel = loginService.loggedInUserModel;

    String uid = userModel != null ? userModel.uid : '';
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: Color(0xff0470a2),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_right,
                              collapseIcon: Icons.arrow_drop_down,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "DOT-Accredited Travel and Tour Agencies and Guides",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('travelagency')
                            .doc('travelagencylist')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var userDocument = snapshot.data;

                            final List<LinkList> linklist = [];

                            userDocument['agencylist'].forEach((value) {
                              linklist
                                  .add(LinkList(value['email'], value['name']));
                            });
                            return linklist.length > 0
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: linklist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Visibility(
                                                    visible: uid ==
                                                            "x19aFGBbXBaXTZY92Al8f8UbWyX2" &&
                                                        index == 0,
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        TextEditingController
                                                            email =
                                                            TextEditingController();
                                                        TextEditingController
                                                            name =
                                                            TextEditingController();

                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Admin: Add New Agency / Guide",
                                                                          style: TextStyle(
                                                                              fontSize: 25,
                                                                              color: Colors.blue[400])),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            //field to comment
                                                                            TextField(
                                                                              controller: name,
                                                                              textCapitalization: TextCapitalization.words,
                                                                              decoration: InputDecoration(
                                                                                labelStyle: TextStyle(color: Colors.grey),
                                                                                labelText: 'Agency Name',
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            TextField(
                                                                              controller: email,
                                                                              textCapitalization: TextCapitalization.words,
                                                                              decoration: InputDecoration(
                                                                                labelStyle: TextStyle(color: Colors.grey),
                                                                                labelText: 'Email',
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            name.clear();
                                                                            email.clear();
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontSize: 18),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            FirebaseFirestore.instance.collection('travelagency').doc('travelagencylist').update({
                                                                              "agencylist": FieldValue.arrayUnion([
                                                                                {
                                                                                  "name": "${name.text}",
                                                                                  "email": "${email.text}"
                                                                                }
                                                                              ])
                                                                            });
                                                                            Navigator.pop(context);
                                                                            showSimpleNotification(
                                                                              Text("A new item has been added!"),
                                                                              background: Colors.green[400],
                                                                              position: NotificationPosition.bottom,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Submit',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.teal,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ));
                                                      },
                                                      child: Text(
                                                          'Admin: Add New Official Link',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[400])),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            String mailto =
                                                                "mailto:" +
                                                                    linklist[
                                                                            index]
                                                                        .link +
                                                                    "?subject=Inquiry&body=Greetings!";
                                                            if (await canLaunch(
                                                                mailto)) {
                                                              await launch(
                                                                  mailto);
                                                            } else {
                                                              showSimpleNotification(
                                                                Text(
                                                                    "Could not lunch $mailto"),
                                                                background:
                                                                    Colors.green[
                                                                        400],
                                                                position:
                                                                    NotificationPosition
                                                                        .bottom,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                              '${linklist[index].name}'),
                                                        ),
                                                        //edit and delete agency
                                                        Row(
                                                          children: [
                                                            Visibility(
                                                              visible: uid ==
                                                                  "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  TextEditingController
                                                                      email =
                                                                      TextEditingController();
                                                                  TextEditingController
                                                                      name =
                                                                      TextEditingController();

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                title: Text("Admin: Edit Agency / Guide", style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      //field to comment
                                                                                      TextField(
                                                                                        controller: name..text = "${linklist[index].name}",
                                                                                        textCapitalization: TextCapitalization.words,
                                                                                        decoration: InputDecoration(
                                                                                          labelStyle: TextStyle(color: Colors.grey),
                                                                                          labelText: 'Agency Name',
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      TextField(
                                                                                        controller: email..text = "${linklist[index].link}",
                                                                                        textCapitalization: TextCapitalization.words,
                                                                                        decoration: InputDecoration(
                                                                                          labelStyle: TextStyle(color: Colors.grey),
                                                                                          labelText: 'Email',
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: Colors.blue[400], width: 1.5),
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
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      name.clear();
                                                                                      email.clear();
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text(
                                                                                      'Cancel',
                                                                                      style: TextStyle(color: Colors.grey, fontSize: 18),
                                                                                    ),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () async {
                                                                                      FirebaseFirestore.instance.collection('travelagency').doc('travelagencylist').update({
                                                                                        "agencylist": FieldValue.arrayRemove([
                                                                                          {
                                                                                            "name": "${linklist[index].name}",
                                                                                            "email": "${linklist[index].link}"
                                                                                          }
                                                                                        ])
                                                                                      });

                                                                                      FirebaseFirestore.instance.collection('travelagency').doc('travelagencylist').update({
                                                                                        "agencylist": FieldValue.arrayUnion([
                                                                                          {
                                                                                            "name": "${name.text}",
                                                                                            "email": "${email.text}"
                                                                                          }
                                                                                        ])
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                      showSimpleNotification(
                                                                                        Text("List has been edited"),
                                                                                        background: Colors.green[400],
                                                                                        position: NotificationPosition.bottom,
                                                                                      );
                                                                                    },
                                                                                    child: Text(
                                                                                      'Submit',
                                                                                      style: TextStyle(
                                                                                        color: Colors.teal,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                },
                                                                icon: Icon(
                                                                    Icons.edit,
                                                                    size: 16,
                                                                    color: Colors
                                                                            .red[
                                                                        400]),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: uid ==
                                                                  "x19aFGBbXBaXTZY92Al8f8UbWyX2",
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      //field to comment
                                                                                      Text("Admin: Do you really want to delete this item?", style: TextStyle(fontSize: 25, color: Colors.blue[400])),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () async {
                                                                                      FirebaseFirestore.instance.collection('travelagency').doc('travelagencylist').update({
                                                                                        "agencylist": FieldValue.arrayRemove([
                                                                                          {
                                                                                            "name": "${linklist[index].name}",
                                                                                            "email": "${linklist[index].link}"
                                                                                          }
                                                                                        ])
                                                                                      });
                                                                                      Navigator.pop(context);

                                                                                      showSimpleNotification(
                                                                                        Text("Item removed"),
                                                                                        background: Colors.green[400],
                                                                                        position: NotificationPosition.bottom,
                                                                                      );
                                                                                    },
                                                                                    child: Text(
                                                                                      'Delete',
                                                                                      style: TextStyle(
                                                                                        color: Colors.teal,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                },
                                                                icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 16,
                                                                    color: Colors
                                                                            .red[
                                                                        400]),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                : linklist.length == null
                                    ? SizedBox()
                                    : SizedBox();
                          } else if (snapshot.hasError) {
                            return SizedBox();
                          } else
                            return Text(
                              'Loading',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            );
                        }),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}

/*List travelagencies = [
  ({
    "name": "B and C Island Leisure Tours",
    "email": "bandcleisuretours@yahoo.com.ph"
  }),
  ({"name": "Bamboo Travel and Tours", "email": "bambootraveltours@gmail.com"}),
  ({"name": "Boracay Adventures Inc.", "email": "info@boracayadventures.com"}),
  ({
    "name": "Blue Horizon Travel & Tours Inc.",
    "email": "maritess.santiago@bluehorizons.travel"
  }),
  ({"name": "Debora Free Tour Inc.", "email": "mg12500@hanmail.net"}),
  ({"name": "Easy Boracay Travel and Tours", "email": "easyboracay@gmail.com"}),
  ({"name": "Horizon Tours", "email": "luzvillabondoc1964@gmail.com"}),
  ({"name": "MBG travel and Tour Inc.", "email": "info@myboracayguide.com"}),
];*/

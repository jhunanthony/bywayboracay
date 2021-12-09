import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../Navigation/TopNavBar.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  //final TextEditingController _numberCtrl2 = TextEditingController();
  String _numberCtrl1;
  String _numberCtrl2;
  String _numberCtrl3;
  String _numberCtrl4;
  String _numberCtrl5;
  String _numberCtrl6;
  String _numberCtrl7;
  String _numberCtrl8;
  String _numberCtrl9;

  @override
  void initState() {
    super.initState();
    _numberCtrl1 = "+63362881278";
    _numberCtrl2 = "+63362884198";
    _numberCtrl3 = "+288-5701";
    _numberCtrl4 = "09616537163";
    _numberCtrl5 = "+09296864146";
    _numberCtrl6 = "+63362883689";
    _numberCtrl7 = "+63362883689";
    _numberCtrl8 = "288-2068";
    _numberCtrl9 = "036 288-3041";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Icon(Icons.add_box_rounded,
                        color: Colors.redAccent, size: 50),
                  ),
                  Text('Emegency',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text('Hotlines',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "AMC HOTLINE\n$_numberCtrl2",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl1);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "BUREAU OF FIRE\n$_numberCtrl3",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl2);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "ACTION CENTER\n$_numberCtrl4",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl3);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "MDRRMO             \n$_numberCtrl5",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl4);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "COAST GUARD\n$_numberCtrl6",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl5);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "POLICE STATION\n$_numberCtrl6",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl6);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "LIFE GUARD\n$_numberCtrl6",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl7);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "RED CROSS\n$_numberCtrl6",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl8);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Color(0xff9edeee),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "CIRIACO HOSPITAL\n$_numberCtrl6",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(_numberCtrl9);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

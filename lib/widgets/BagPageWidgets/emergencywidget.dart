import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../Navigation/TopNavBar.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  List<Map<String, dynamic>> contactsitem = [
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fredcross.jpg?alt=media&token=2ce431c0-7b85-4512-9ab7-32c2096ce9b6",
      "name": "Red Cross",
      "number": "288-2068",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Flife%20guard.jpg?alt=media&token=ac37e2c6-fa05-481c-89c5-7f90f36df708",
      "name": "Life Guard",
      "number": "+63362883689",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Famc.jpg?alt=media&token=92117b22-f3cf-4fc3-89f2-dc79fe856fd5",
      "name": "AMC Alert Medical Clinic",
      "number": "+63362884198",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fciriaco%20hospital.jpg?alt=media&token=73e7c92e-7b7f-41dc-ace0-26d5d63dac47",
      "name": "CIRIACO Hospital",
      "number": "036 288-3041",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fcoast%20guard.jpg?alt=media&token=6f82965a-1da9-48e1-a0fb-b55b4c24cb0b",
      "name": "Coast Guard",
      "number": "+09296864146",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fbfp.jpg?alt=media&token=5ae2232f-b02e-49d8-b9c4-6feaeae548eb",
      "name": "Bureau of Fire Protection",
      "number": "+288-5701",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fpnp.jpg?alt=media&token=b87a5d72-87bc-42a2-9fb9-841de3214ce7",
      "name": "Police Station",
      "number": "+63362883689",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Fmdrrmc.jpg?alt=media&token=c691c82b-52ea-49c1-a0a2-2e2965d431c6",
      "name": "MDRRMO",
      "number": "09616537163",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/bywayboracay_Hotline_Icons%2Faction%20center.jpg?alt=media&token=2b175338-1303-4019-a756-cae5b892784a",
      "name": "Action Center",
      "number": "288-5701",
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 25, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
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
            Expanded(
              child: ListView.builder(
                  itemCount: contactsitem.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                                child: Image.network(
                                    "${contactsitem[index]['imgName']}",
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover)),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "${contactsitem[index]['name']}\n${contactsitem[index]['number']}",
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
                                FlutterPhoneDirectCaller.callNumber(
                                    contactsitem[index]['number']);
                              },
                              child: Wrap(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_rounded,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

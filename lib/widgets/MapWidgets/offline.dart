import 'package:flutter/material.dart';

class Offline_Map extends StatefulWidget {


  @override
  _Offline_MapState createState() => _Offline_MapState();
}

class _Offline_MapState extends State<Offline_Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'Offline Map',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Image.asset('assets/images/1.png'),
            ),
          ],
        ),
      ),
    );
  }
}

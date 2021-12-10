import 'package:flutter/material.dart';

import '../../Navigation/TopNavBar.dart';
import 'locations_widget.dart';

class LocalProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        appBar: TopNavBar(colorbackground: Colors.transparent, theme: Colors.white),
        body: LocationsWidget(),
      );

      
}

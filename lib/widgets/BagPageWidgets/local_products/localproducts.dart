import 'package:flutter/material.dart';

import 'locations_widget.dart';


class LocalProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: buildAppBar(),
        body: LocationsWidget(),
      );

  Widget buildAppBar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('LOCAL PRODUCTS'),
        centerTitle: true,
      );
}

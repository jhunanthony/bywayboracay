import 'package:flutter/material.dart';

import 'location_widget.dart';
import 'locations.dart';

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: 5),
          Text("LOCAL EVENTS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: localevents.length,
              itemBuilder: (context, index) {
                final location = localevents[index];

                return LocationWidget(location: location);
              },
              onPageChanged: (index) => setState(() => pageIndex = index),
            ),
          ),
          Text(
            '${pageIndex + 1}/${localevents.length}',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 5)
        ],
      );
}

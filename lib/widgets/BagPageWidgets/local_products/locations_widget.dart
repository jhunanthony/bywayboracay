import 'package:bywayborcay/widgets/BagPageWidgets/local_products/locations.dart';
import 'package:flutter/material.dart';

import 'location_widget.dart';

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
          Text("LOCAL PRODUCTS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: localproducts.length,
              itemBuilder: (context, index) {
                final location = localproducts[index];

                return LocationWidget(location: location);
              },
              onPageChanged: (index) => setState(() => pageIndex = index),
            ),
          ),
          Text(
            '${pageIndex + 1}/${localproducts.length}',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 5)
        ],
      );
}




import 'package:bywayborcay/widgets/BagPageWidgets/local_events/locations.dart';
import 'package:flutter/material.dart';



class ExpandedContentWidget extends StatelessWidget {
  final Location location;

  const ExpandedContentWidget({
    @required this.location,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(location.addressLine1),
            SizedBox(height: 8),
            buildAddressRating(location: location),
            SizedBox(height: 12),
           
          ],
        ),
      );

  Widget buildAddressRating({
    @required Location location,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            location.addressLine2,
            style: TextStyle(color: Colors.black, 
            fontWeight: FontWeight.bold),
          ),
        ],
      );

}


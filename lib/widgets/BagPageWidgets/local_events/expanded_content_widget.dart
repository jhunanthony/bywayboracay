import 'package:bywayborcay/widgets/BagPageWidgets/local_events/locations.dart';
import 'package:flutter/material.dart';

class ExpandedContentWidget extends StatelessWidget {
  final LocalEventsModel location;

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
            Text(location.description,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                )),
            SizedBox(height: 8),
          ],
        ),
      );
}

import 'dart:ui';

import 'package:bywayborcay/widgets/BagPageWidgets/local_events/locations.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final LocalEventsModel location;

  const ImageWidget({
    @required this.location,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Image.asset(location.urlImage, fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaY: 19.2, sigmaX: 19.2),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 15, bottom: 15),
                                  alignment: Alignment.center,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(location.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            )),
                                      ]))))),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

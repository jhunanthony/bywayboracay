import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
//create the transit/tariff features here

class MapBottomInfo extends StatelessWidget {
  String farevalue = 'Tourist';
  /*var fareitems = [
    'Tourist',
    'Local',
    'Under Age',
    'Student',
    'Senior',
  ];*/

  Items items;

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    this.items = catSelection.items;

    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero)
            ]),
        child: Column(children: [
          Container(
              color: Colors.transparent,
              child: Row(children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                        child: Image.asset(
                            'assets/images/${this.items.imgName}.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover)),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: Image.asset('assets/images/'+ this.items.markerName +'.png',
                          height: 30, width: 30),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.items.name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(this.items.address),
                      ]),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[200], //background
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15), //foreground
                              shape: CircleBorder()),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.car_fill,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {}),
                      SizedBox(height: 5),
                      Text(
                        'Transit Fare',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ]),

                /*Icon(Icons.location_pin,
                    color: AppColors.accomodations, size: 50)*/
              ])),
          SizedBox(height: 10),
          /*Container(
              child: Column(children: [
            Row(children: [
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                    Row(children: [
                      //add drop down to personalize fare
                      DropdownButton(
                        value: farevalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: fareitems.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            farevalue = newValue;
                          });
                        },
                      ),
                      Text(
                        ': Php 100.00',
                      )
                    ]),
                  ])),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[200], //background
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15), //foreground
                      shape: CircleBorder()),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.car_fill,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {}),
            ])
          ]))*/
        ]));
  }
}

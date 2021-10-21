import 'dart:ui';

import 'ItemsModel.dart';

//This represents the category and holds properties
class Category {
  String name;
  String iconName;
  Color color;
  String imgName;
  List<Items> items;

  //add additional holders
  String description;
  String address;
  String station;
  double lat;
  double long;
  String contactnumber;
  String categoryName;
  String markerName;
  String subcategoryName;
  String email;
  String website;
  String socialmedia;
 
  int likes;
  double rating1;
  double rating2;
  String opentime;
  double pricemin;

//Contructor to hydrate the model
  Category({
    this.name,
    this.iconName,
    this.color,
    this.imgName,
    this.items,
    this.description,
    this.address,
    this.station,
    this.lat,
    this.long,
    this.contactnumber,
    this.categoryName,
    this.markerName,
    this.subcategoryName,
    this.email,
    this.website,
    this.socialmedia,
  
    this.likes,
    this.rating1,
     this.rating2,
    this.opentime,
    this.pricemin,
  });
}

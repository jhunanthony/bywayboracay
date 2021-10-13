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
  String lat;
  String long;
  String contactnumber;
  String categoryName;
  String email;
  String website;
  String socialmedia;
  int likes;
  int saves;
  double rating;
  String opentime;
  String pricemin;

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
    this.email,
    this.website,
    this.socialmedia,
    this.likes,
    this.saves,
    this.rating,
    this.opentime,
    this.pricemin,
  });
}

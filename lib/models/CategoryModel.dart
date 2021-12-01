import 'dart:ui';

import 'ItemsModel.dart';

//This represents the category and holds properties
class Category {
  String name;

  Color color;
  String imgName;
  List<Items> items;

  //add additional holders
  String itemname;

  Color itemcolor;
  String itemimgName;
  String itemdescription;
  String itemaddress;
  String itemstation;
  double itemlat;
  double itemlong;
  String itemcontactNumber;
  String itemcategoryName;

  String itemsubcategoryName;
  String itememail;
  String itemwebsite;

  String itemopenTime;
  double itempriceMin;

//Contructor to hydrate the model
  Category({
    this.name,
    this.color,
    this.imgName,
    this.items,
    this.itemname,
    this.itemcolor,
    this.itemimgName,
    this.itemdescription,
    this.itemaddress,
    this.itemstation,
    this.itemlat,
    this.itemlong,
    this.itemcontactNumber,
    this.itemcategoryName,
    this.itemsubcategoryName,
    this.itememail,
    this.itemwebsite,
    this.itemopenTime,
    this.itempriceMin,
  });

  //factory method to mapp json structure and hidrate all the value
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      color: Color(int.parse('0xFF' + json['color'])),
      name: json['name'],
      imgName: json['imgName'],
      items: Items.fromJsonArray(json['items']),
    );
  }
}

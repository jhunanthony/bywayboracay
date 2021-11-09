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
 String itemname;
  String itemiconName;
  Color itemcolor;
  String itemimgName;
  String itemdescription;
  String itemaddress;
  String itemstation;
  double itemlat;
  double itemlong;
  String itemcontactNumber;
  String itemcategoryName;
  String itemmarkerName;
  String itemsubcategoryName;
  String itememail;
  String itemwebsite;
 
 
 
  double itemrating1;
  String itemratingname;
  String itemopenTime;
  double itempriceMin;

//Contructor to hydrate the model
  Category({
    this.name,
    this.iconName,
    this.color,
    this.imgName,
    this.items,

    this.itemname,
    this.itemiconName,
    this.itemcolor,
    this.itemimgName,
    this.itemdescription,
    this.itemaddress,
    this.itemstation,
    this.itemlat,
    this.itemlong,
    this.itemcontactNumber,
    this.itemcategoryName,
    this.itemmarkerName,
    this.itemsubcategoryName,
    this.itememail,
    this.itemwebsite,
   
  
   
    this.itemrating1,
     this.itemratingname,
    this.itemopenTime,
    this.itempriceMin,
  });

  //factory method to mapp json structure and hidrate all the value
  factory Category.fromJson(Map<String, dynamic> json) {
    
    return Category(
      color: Color(int.parse('0xFF' + json['color'])),
      iconName: json['iconName'],
      name: json['name'],
      imgName: json['imgName'],
      items: Items.fromJsonArray(json['items']),
    );
  }
}

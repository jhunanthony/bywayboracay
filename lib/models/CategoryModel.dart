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
  String itemsocialMedia;
 
 
  double itemrating1;
  double itemrating2;
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
    this.itemsocialMedia,
  
   
    this.itemrating1,
     this.itemrating2,
    this.itemopenTime,
    this.itempriceMin,
  });
}

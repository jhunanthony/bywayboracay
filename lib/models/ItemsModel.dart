import 'dart:ui';

import 'CategoryModel.dart';
import 'DetailImages.dart';

//create a model that represents subcat that derives from category model
class Items extends Category {
  List<DetailsImages> detailsimages;

  
String itemname;

  String itemdescription;
  String itemaddress;
  String itemstation;
  double itemlat;
  double itemlong;
  String itemcontactNumber;
  String itemsubcategoryName;
  String itemmarkerName;

  String itememail;
  String itemwebsite;
  String itemsocialMedia;
  double itemrating1;
  double itemrating2;
  String itemopenTime;
  double itempriceMin;

  Items({
    this.detailsimages,
    
    String itemcaticonName,
    Color itemcatcolor,
    String itemcatimgName,
    String itemcategoryName,
    //initialized other variables to pass to itemmodel
    this.itemname,
    this.itemdescription,
    this.itemaddress,
    this.itemstation,
    this.itemlat,
    this.itemlong,
    this.itemcontactNumber,
    this.itemsubcategoryName,
    this.itemmarkerName,
    this.itememail,
    this.itemwebsite,
    this.itemsocialMedia,
    this.itemrating1,
    this.itemrating2,
    this.itemopenTime,
    this.itempriceMin,
   /* String itemname,

  String itemdescription,
  String itemaddress,
  String itemstation,
  double itemlat,
  double itemlong,
  String itemcontactNumber,
  String itemsubcategoryName,
  String itemmarkerName,

  String itememail,
  String itemwebsite,
  String itemsocialMedia,
  double itemrating1,
  double itemrating2,
  String itemopenTime,
  double itempriceMin,*/
  }) :
        //use super to refer to a class to transer same value

        super(
          iconName: itemcaticonName,
          color: itemcatcolor,
          imgName: itemcatimgName,
          catname: itemcategoryName,

          //pass additional data
          /*description: itemdescription,
          address: itemaddress,
          station: itemstation,
          lat: itemlat,
          long: itemlong,
          contactNumber: itemcontactNumber,
          markerName: itemmarkerName,
          subcategoryName: itemsubcategoryName,
          categoryName: itemcategoryName,
          email: itememail,
          website: itemwebsite,
          socialMedia: itemsocialMedia,

       
          rating1: itemrating1,
          rating2: itemrating2,
          openTime: itemopenTime,
          priceMin: itempriceMin,*/
        );

  //factory constructor
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      itemaddress: json['address'],
      itemcategoryName: json['categoryName'],
      itemcatcolor: Color(int.parse('OxFF' + json['color'])),
      itemcontactNumber: json['contactNumber'],
      itemdescription: json['description'],
      detailsimages: DetailsImages.fromJsonArray(json['detailsimages']),
      itememail: json['email'],
      itemcaticonName: json['iconName'],
      itemcatimgName: json['imgName'],
      itemlat: double.parse(json['lat']),
      itemlong: double.parse(json['long']),
      itemmarkerName: json['markerName'],
      itemname: json['name'],
      itemopenTime: json['openTime'],
      itempriceMin: double.parse(json['priceMin']),
      itemrating1: double.parse(json['rating1']),
      itemrating2: double.parse(json['rating2']),
      itemsocialMedia: json['socialMedia'],
      itemstation: json['station'],
      itemsubcategoryName: json['subcategoryName'],
      itemwebsite: json['website'],
    );
  }
  //add the json array
  static List<Items> fromJsonArray(List<dynamic> jsonArray) {
    List<Items> itemsFromJson = [];

    //loop in this list
    jsonArray.forEach((jsonData) {
      //add factory constructor
      itemsFromJson.add(Items.fromJson(jsonData));
    });

    return itemsFromJson;
  }
}

import 'dart:ui';

import 'CategoryModel.dart';
import 'DetailImages.dart';

//create a model that represents subcat that derives from category model
class Items extends Category {
  List<DetailsImages> detailsimages;
  int amount;

  Items({
    this.detailsimages,
    this.amount = 0,
    String itemname,
    Color itemcolor,
    String itemimgName,
    //initialized other variables to pass to itemmodel
    String itemdescription,
    String itemaddress,
    String itemstation,
    double itemlat,
    double itemlong,
    String itemcontactNumber,
    String itemsubcategoryName,
    String itemcategoryName,
    String itememail,
    String itemwebsite,
    String itemopenTime,
    double itempriceMin,
  }) :
        //use super to refer to a class to transer same value
        super(
          //pass additional data
          name: itemname,
          color: itemcolor,
          imgName: itemimgName,

          /*itemname: itemname,
          itemiconName: itemiconName,
          itemcolor: itemcolor,
          itemimgName: itemimgName,*/
          itemdescription: itemdescription,
          itemaddress: itemaddress,
          itemstation: itemstation,
          itemlat: itemlat,
          itemlong: itemlong,
          itemcontactNumber: itemcontactNumber,
          itemsubcategoryName: itemsubcategoryName,
          itemcategoryName: itemcategoryName,
          itememail: itememail,
          itemwebsite: itemwebsite,
          itemopenTime: itemopenTime,
          itempriceMin: itempriceMin,
        );

  //factory constructor
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      amount: 0,
      itemaddress: json['itemaddress'],
      itemcategoryName: json['itemcategoryName'],
      itemcolor: Color(int.parse('0xFF' + json['itemcolor'])),
      itemcontactNumber: json['itemcontactNumber'],
      itemdescription: json['itemdescription'],
      detailsimages: DetailsImages.fromJsonArray(json['itemdetailsimages']),
      itememail: json['itememail'],
      itemimgName: json['itemimgName'],
      itemlat: double.parse(json['itemlat']),
      itemlong: double.parse(json['itemlong']),
      itemname: json['itemname'],
      itemopenTime: json['itemopenTime'],
      itempriceMin: double.parse(json['itempriceMin']),
      itemstation: json['itemstation'],
      itemsubcategoryName: json['itemsubcategoryName'],
      itemwebsite: json['itemwebsite'],
    );
  }

  //add the json array
  static List<Items> fromJsonArray(List<dynamic> jsonArray) {
    List<Items> itemsFromJson = [];

    jsonArray.forEach((jsonData) {
      itemsFromJson.add(Items.fromJson(jsonData));
    });

    return itemsFromJson;
  }
}

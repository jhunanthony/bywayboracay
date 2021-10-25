import 'dart:ui';

import 'CategoryModel.dart';
import 'DetailImages.dart';

//create a model that represents subcat that derives from category model
class Items extends Category {
  List<DetailsImages> detailsimages;

  Items({
    this.detailsimages,
    String itemname,
    String itemiconName,
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
    String itemmarkerName,
    String itemcategoryName,
    String itememail,
    String itemwebsite,
    String itemsocialMedia,
  
 
    double itemrating1,
    double itemrating2,
    
    String itemopenTime,
    double itempriceMin,
  }) :
        //use super to refer to a class to transer same value
        super(
          //pass additional data
          name: itemname,
          iconName: itemiconName,
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
          itemmarkerName: itemmarkerName,
          itemsubcategoryName: itemsubcategoryName,
          itemcategoryName: itemcategoryName,
          itememail: itememail,
          itemwebsite: itemwebsite,
          itemsocialMedia: itemsocialMedia,
        
    
          itemrating1: itemrating1,
          itemrating2: itemrating2,
          itemopenTime: itemopenTime,
          itempriceMin: itempriceMin,
        );


        //factory constructor
  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      itemaddress: json['itemaddress'],
      itemcategoryName: json['itemcategoryName'],
      itemcolor: Color(int.parse('0xFF' + json['itemcolor'])),
      itemcontactNumber: json['itemcontactNumber'],
      itemdescription: json['itemdescription'],
      detailsimages: DetailsImages.fromJsonArray(json['itemdetailsimages']),
      itememail: json['itememail'],
      itemiconName: json['itemiconName'],
      itemimgName: json['itemimgName'],
      itemlat: double.parse(json['itemlat']),
      itemlong: double.parse(json['itemlong']),
      itemmarkerName: json['itemmarkerName'],
      itemname: json['itemname'],
      itemopenTime: json['itemopenTime'],
      itempriceMin: double.parse(json['itempriceMin']),
      itemrating1: double.parse(json['itemrating1']),
      itemrating2: double.parse(json['itemrating2']),
      itemsocialMedia: json['itemsocialMedia'],
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

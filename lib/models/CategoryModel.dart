import 'dart:ui';

import 'ItemsModel.dart';

//This represents the category and holds properties
class Category {
  String catname;
  String iconName;
  Color color;
  String imgName;
  List<Items> items;



//Contructor to hydrate the model
  Category({
    this.catname,
    this.iconName,
    this.color,
    this.imgName,
    this.items,


   
    

  });

  //factory method to mapp json structure and hidrate all the value
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      color: Color(int.parse('0xFF' + json['color'])),
      iconName: json['iconName'],
      catname: json['name'],
      imgName: json['imgName'],
      items: Items.fromJsonArray(json['items'])


    );
  }
}

import 'dart:ui';

class ForYouContent {
  String name;

  String address;
  String description;
  String img1;
  String img2;
  String img3;

  ForYouContent({this.name,  this.address, this.description, this.img1, this.img2,this.img3});
}

class HighlightModel {
  String name;
  String imgName;
  Color color;
  String caption;

  HighlightModel({
    this.name,
    this.imgName,
    this.color,
    this.caption,
  });
}

class HistoryModel {
  String imgName;

  HistoryModel({
    this.imgName,
  });
}

class CultureModel {
  String name;
  String imgName;
  String caption;

  CultureModel({
    this.name,
    this.imgName,
    this.caption,
  });
}

class AwardsModel {
  String name;
  String imgName;
  String caption;

  AwardsModel({
    this.name,
    this.imgName,
    this.caption,
  });
}

//this constructor will show list of images
class DetailsImages {
  String imgName;

  DetailsImages({this.imgName});

  //create method like categor
  factory DetailsImages.fromJson(Map<String, dynamic> json) {
    return DetailsImages(imgName: json['detailsimagesimgName']);
  }

  static List<DetailsImages> fromJsonArray(List<dynamic> jsonDetailsImages) {
    List<DetailsImages> detailsimages = [];

    jsonDetailsImages.forEach((jsonData) {
      detailsimages.add(DetailsImages.fromJson(jsonData));
    });
    return detailsimages;
  }
}

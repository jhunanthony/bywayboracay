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
  
    int itemlikes,
    double itemrating1,
    double itemrating2,
    
    String itemopenTime,
    double itempriceMin,
  }) :
        //use super to refer to a class to transer same value
        super(
          name: itemname,
          iconName: itemiconName,
          color: itemcolor,
          imgName: itemimgName,

          //pass additional data
          description: itemdescription,
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
        
          likes: itemlikes,
          rating1: itemrating1,
          rating2: itemrating2,
          openTime: itemopenTime,
          priceMin: itempriceMin,
        );
}

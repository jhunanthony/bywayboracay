import 'dart:ui';

import 'CategoryModel.dart';
import 'DetailImages.dart';

//create a model that represents subcat that derives from category model
class Items extends Category {
  List<DetailsImages> detailsimages;

  Items({
    this.detailsimages,
    String itemname,
    String itemicon,
    Color itemcolor,
    String itemimgName,
    //initialized other variables to pass to itemmodel
    String itemdescription,
    String itemaddress,
    String itemstation,
    String itemlat,
    String itemlong,
    String itemcontactnumber,
    String itemsubcategoryName,
    String itememail,
    String itemwebsite,
    String itemsocialmedia,
    int itemlikes,
    int itemsaves,
    double itemrating,
    String itemopentime,
    String itempricemin,
  }) :
        //use super to refer to a class to transer same value
        super(
          name: itemname,
          iconName: itemicon,
          color: itemcolor,
          imgName: itemimgName,

          //pass additional data
          description: itemdescription,
          address: itemaddress,
          station: itemstation,
          lat: itemlat,
          long: itemlong,
          contactnumber: itemcontactnumber,
          categoryName: itemsubcategoryName,
          email: itememail,
          website: itemwebsite,
          socialmedia: itemsocialmedia,
          likes: itemlikes,
          saves: itemsaves,
          rating: itemrating,
          opentime: itemopentime,
          pricemin: itempricemin,
        );
}

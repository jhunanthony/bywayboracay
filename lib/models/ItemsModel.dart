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
}

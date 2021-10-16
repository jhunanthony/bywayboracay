//this is a temporary mock data generator

import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/DetailImages.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/OnBoardingModel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'AppColors.dart';
import 'AppIcons.dart';

class Utils {
  //create static onboardingcontent the will return content ref
  static List<OnBoardingContent> getOnBoarding() {
    return [
      OnBoardingContent(
        message: 'This product is for flexibility',
        imgName: 'Test_Image_1',
      ),
      OnBoardingContent(
        message: 'This product is for Navigation',
        imgName: 'Test_Image_2',
      ),
      OnBoardingContent(
        message: 'This product is for Budget',
        imgName: 'Test_Image_3',
      ),
      OnBoardingContent(
        message: 'This product is for Communication',
        imgName: 'Test_Image_4',
      )
    ];
  }

  //create static method that will return categories with data
  static List<Category> getMockedCategory() {
    return [
      Category(
          color: AppColors.ToStayColor,
          name: 'To Stay',
          imgName: 'Test_Image_1',
          iconName: AppIcons.ToStayIcon,
          items: [
            Items(
                itemcolor: AppColors.ToStayColor,
                itemicon: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 1',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
                
                itemlat: 11.987426774719031,
                itemlong: 121.90622655889455,
                itemimgName: 'Test_Image_3',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactnumber: "(63 36) 288 4988",
                itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',

                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialmedia: "https://web.facebook.com/ShangriLaBoracay",
                itemlikes: 563,
                itemsaves: 146,
                itemrating1: 4.5,
                itemrating2: 4.8,
                itemopentime: '8am - 10pm',
                itempricemin: '2,000.00',
                detailsimages: [
                  DetailsImages(
                    imgName: 'Test_Image_1',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_3',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_5',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_2',
                  )
                ]),
            Items(
                itemcolor: AppColors.ToStayColor,
                itemicon: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 2',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
             
                itemlat: 11.9719344536077,
                itemlong: 121.91660472762166,
                itemimgName: 'Test_Image_2',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactnumber: "(63 36) 288 4988",
                 itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',
                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialmedia: "https://web.facebook.com/ShangriLaBoracay",
                itemlikes: 563,
                itemsaves: 146,
                itemrating1: 4.5,
                itemrating2: 4.8,
                itemopentime: '8am - 10pm',
                itempricemin: '2,000.00',
                detailsimages: [
                  DetailsImages(
                    imgName: 'Test_Image_1',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_3',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_5',
                  ),
                  DetailsImages(
                    imgName: 'Test_Image_2',
                  )
                ]),
            Items(
                itemcolor: AppColors.ToStayColor,
                itemicon: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 3',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
               itemlat: 11.987426774719031,
                itemlong: 121.90622655889455,
                itemimgName: 'Test_Image_5',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactnumber: "(63 36) 288 4988",
                 itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',
                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialmedia: "https://web.facebook.com/ShangriLaBoracay/",
                itemlikes: 86,
                itemsaves: 135,
                itemrating1: 4.5,
                itemrating2: 5,
                itemopentime: '9am - 10pm',
                itempricemin: '8,000.00'),
            Items(
                itemcolor: AppColors.ToStayColor,
                itemicon: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 4',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
             itemlat: 11.987426774719031,
                itemlong: 121.90622655889455,
                itemimgName: 'Test_Image_2',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactnumber: "(63 36) 288 4988",
                 itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',
                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialmedia: "https://web.facebook.com/ShangriLaBoracay/",
                itemlikes: 87,
                itemsaves: 146,
                itemrating1: 4.5,
                itemrating2: 5,
                itemopentime: '9am - 10pm',
                itempricemin: '10,000.00'),
            Items(
                itemcolor: AppColors.ToStayColor,
                itemicon: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 5',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
            itemlat: 11.987426774719031,
                itemlong: 121.90622655889455,
                itemimgName: 'Test_Image_1',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactnumber: "(63 36) 288 4988",
                 itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',
                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialmedia: "https://web.facebook.com/ShangriLaBoracay",
                itemlikes: 200,
                itemsaves: 0,
                itemrating1: 4.5,
                itemrating2: 5,
                itemopentime: '9am - 10pm',
                itempricemin: '5,000.00'),
          ]),
      Category(
          color: AppColors.ToEatandDrinkColor,
          name: 'To Eat & Drink',
          imgName: 'Test_Image_2',
          iconName: AppIcons.ToEatandDrinkIcon,
          items: []),
      Category(
          color: AppColors.ToSeeColor,
          name: 'To See',
          imgName: 'Test_Image_3',
          iconName: AppIcons.ToSeeIcon,
          items: []),
      Category(
          color: AppColors.ToDoColor,
          name: 'To Do',
          imgName: 'Test_Image_4',
          iconName: AppIcons.ToDoIcon,
          items: []),
    ];
  }

  
}

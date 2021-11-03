//this is a temporary mock data generator

import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/DetailImages.dart';
import 'package:bywayborcay/models/ForYouModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/OnBoardingModel.dart';


import 'AppColors.dart';
import 'AppIcons.dart';

class Utils {
  //create static onboardingcontent the will return content ref
  static List<OnBoardingContent> getOnBoarding() {
    return [
      OnBoardingContent(
        message: 'Explore Boracay and create your own tour plan with ease and flexibility.',
        imgName: 'Planning',
      ),
      OnBoardingContent(
        message: 'Navigation to your desired place with accuracy.',
        imgName: 'Navigation',
      ),
      OnBoardingContent(
        message: 'No more worries on budgeting hassles.',
        imgName: 'Budgeting',
      ),
      OnBoardingContent(
        message: 'Freely express your self with Byway Boracay.',
        imgName: 'Communication',
      )
    ];
  }

  static List<ForYouContent> getForyouContents() {
    return [
      ForYouContent(
        name: 'White Beach',
        imgName: 'ForYou1',
        address: 'Balabag, Malay, Aklan',
      ),
      ForYouContent(
        name: 'New Coast Stone Hendge',
        imgName: 'ForYou2',
        address: 'Yapak, Malay, Aklan'
      ),
      ForYouContent(
        name: 'Mt. Luho',
        imgName: 'ForYou3',
        address: 'Balabag, Malay, Aklan'
      ),
      ForYouContent(
        name: 'Puka Beach',
        imgName: 'ForYou4',
        address: 'Yapak, Malay, Aklan'
      )
    ];
  }

  //create static method that will return categories with data
  /*static List<Category> getMockedCategory() {
    return [
      Category(
          color: AppColors.ToStayColor,
          name: 'To Stay',
          imgName: 'Test_Image_1',
          iconName: AppIcons.ToStayIcon,
          items: [
            Items(
            
                itemcolor: AppColors.ToStayColor,
                itemiconName: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 1',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
                itemlat: 11.987426774719031,
                itemlong: 121.90622655889455,
                itemimgName: 'Test_Image_3',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactNumber: "(63 36) 288 4988",
                itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',

                itemsubcategoryName: 'Hotel',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialMedia: "https://web.facebook.com/ShangriLaBoracay",
               
                //erase likes
           
                itemrating1: 4.5,
                itemrating2: 4.8,
                itemopenTime: '8am - 10pm',
                itempriceMin: 2000.00,
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
                itemiconName: AppIcons.ToStayIcon,
                itemname: 'Boracay Hotel 2',
                itemaddress: 'Balabag, Malay, Aklan',
                itemstation: 'Balabag',
                
             
                itemlat: 11.9719344536077,
                itemlong: 121.91660472762166,
                itemimgName: 'Test_Image_2',
                itemdescription:
                    "Nestled in a sheltered bay on Boracay’s pristine northern coastline, Shangri-La’s Boracay Resort & Spa, Philippines exudes tropical island luxury. It has 219 rooms and villas showcasing contemporary style, enriched with Filipino touches. The resort’s layout offers spectacular vistas of lush green scenery and azure ocean views from every vantage point.",
                itemcontactNumber: "(63 36) 288 4988",
                 itemcategoryName: 'To Stay',
                itemmarkerName: 'To_Stay_Marker',
                itemsubcategoryName: 'Hotels',
                itememail: "boracay@shangri-la.com",
                itemwebsite:
                    "https://www.shangri-la.com/en/boracay/boracayresort/",
                itemsocialMedia: "https://web.facebook.com/ShangriLaBoracay",
            
                itemrating1: 4.5,
                itemrating2: 4.8,
                itemopenTime: '8am - 10pm',
                itempriceMin: 2000.00,
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
           
          ]),
      Category(
          color: AppColors.ToEatandDrinkColor,
          name: 'To Eat&Drink',
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
  }*/

  
}

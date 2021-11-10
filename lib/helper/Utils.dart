//this is a temporary mock data generator

import 'package:bywayborcay/models/ExplorePageModels.dart';

import 'package:bywayborcay/models/OnBoardingModel.dart';
import 'package:flutter/material.dart';

class Utils {
  //create static onboardingcontent the will return content ref
  static List<OnBoardingContent> getOnBoarding() {
    return [
      OnBoardingContent(
        message:
            'Explore Boracay and create your own tour plan with ease and flexibility.',
        imgName: 'Planning',
      ),
      OnBoardingContent(
        message: 'Navigate to your desired place with accuracy.',
        imgName: 'Navigation',
      ),
      OnBoardingContent(
        message: 'No more worries on budgeting hassles.',
        imgName: 'Budgeting',
      ),
      OnBoardingContent(
        message: 'Effective communication with BYWAY Boracay.',
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
          address: 'Yapak, Malay, Aklan'),
      ForYouContent(
          name: 'Mt. Luho',
          imgName: 'ForYou3',
          address: 'Balabag, Malay, Aklan'),
      ForYouContent(
          name: 'Puka Beach',
          imgName: 'ForYou4',
          address: 'Yapak, Malay, Aklan')
    ];
  }

  //for highlights
  static List<HighlightModel> getHighlight() {
    return [
      HighlightModel(
          name: 'White Sands', imgName: 'Highlight1', color: Colors.yellow),
      HighlightModel(
          name: 'Crystal Clear Water',
          imgName: 'Highlight2',
          color: Colors.blue),
      HighlightModel(
          name: 'Night Life', imgName: 'Highlight3', color: Colors.purple),
      HighlightModel(
          name: 'Sustainable Tourism',
          imgName: 'Highlight4',
          color: Colors.green)
    ];
  }

  static List<HistoryModel> getHistory() {
    return [
      HistoryModel(
        imgName: 'History1',
      ),
      HistoryModel(
        imgName: 'History2',
      ),
      HistoryModel(
        imgName: 'History3',
      ),
      HistoryModel(
        imgName: 'History4',
      )
    ];
  }

  static List<CultureModel> getculture() {
    return [
      CultureModel(
        name: "Ati-atihan Festival",
        imgName: 'Culture1',
        caption: "Boracay Sto. Niño Ati-atihan is celebrated in the most festive way, starts with a fluvial parade of the image of Sto. Niño at the shores of Boracay followed by a High Mass spearheaded by the Parish of the Most Holy Rosary at Balabag Plaza.",
      ),
      CultureModel(
        name: "Paraw",
        imgName: 'Culture2',
        caption: "Paraw Sailing is a local sail boat activity. The boats use two outriggers and two sails. Experience the traditional way of sailing and discover the best sites around the island.",
      ),
      CultureModel(
        name: "Love Boracay Event",
        imgName: 'Culture3',
        caption: "Laboracay has been rebranded to “Love Boracay” and the focus of the event changed. This weekend is full of events that promotes sustainable tourism.",
      ),
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

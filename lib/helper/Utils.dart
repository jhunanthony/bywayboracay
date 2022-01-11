//this is a temporary mock data generator

import 'dart:math';

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
          name: 'White Sands & Crystal Clear Waters',
          imgName: 'Highlight1',
          color: Colors.blue,
          caption:
              "Boracay's White Beach has been recognized as one of the most beautiful beaches in the world through the years. There's something about its natural beauty – its crystal blue water, its pure white sand, and its magical sunsets."),
      HighlightModel(
          name: 'Night Life',
          imgName: 'Highlight3',
          color: Colors.purple,
          caption:
              "The nightlife in Boracay has a reputation for being over the top. Party animals love Boracay as there are countless beach bars and nightclubs that keep pumping until very late into the night. The happy hours here are incredibly long, with some bars on White Beach offering ‘buy 1, get 1 free’ drink specials from 4pm until around 9pm. And many of them stay open until between 1am and 3am."),
      HighlightModel(
          name: 'Sustainable Tourism',
          imgName: 'Highlight4',
          color: Colors.green,
          caption:
              "Boracay takes pride in its eco-practices which supports the world-wide call for sustainable tourism. Various conservation and preservation practices are woven into the resort's core values to ensure sustainable operations and growth not just for the property but for the local community as well."),
      HighlightModel(
          name: 'Golden Hour',
          imgName: 'ForYou1',
          color: Colors.orange[800],
          caption:
              "Boracay is famous for its White Beach and the powder-like sand that is unlike any other in the world. The breathtaking sunset view on this side of the island is equally adored that a Boracay holiday would not be complete without witnessing the most photographed subject in the island.")
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

  static List<AwardsModel> getawards() {
    return [
      AwardsModel(
          name: "Top beach destination by Travel+Leisure Magazine (2012)",
          imgName: 'awards1',
          caption:
              "With a score of 93.10, the island, which is noted for its powdery white sand and pristine waters, took first place in the magazine's 2012 World's Best Awards, beating out popular Indonesian destination Bali Island, which came in second with a score of 90.41. In 2011, Boracay was placed fourth in the same category. Hotels, islands, destination spas, golf courses, and rental car businesses are all rated in the magazine's annual World's Best Awards. The rating is based on an online poll of the publication's readers. "),
      AwardsModel(
          name:
              "World’s Best Island Beaches in the world 2016 by International Travel Magazine",
          imgName: 'awards2',
          caption:
              "Top #1 on World’s Best Island Beaches in the Condé Nast Traveler 2016 Readers’ Choice AwardsBoracay, Philippines was recently named the Best Island in the World by international travel magazine Condé Nast at the awards night at the 1 World Trade Center in New York City.This itty-bitty island (10-square mile) in the Western Philippines is as close to the tropical idyll as you’ll find in Southeast Asia, with gentle coastlines and transporting sunsets. Add in a thriving nightlife scene, and you have one of the top tourist spots in the region, Condé Nast Traveler wrote."),
      AwardsModel(
        name:
            "Boracay rehabilitation won an award at Japan Tourism Awards (2019)",
        imgName: 'awards3',
        caption:
            "According to the Philippines News Agency, DOT Secretary Bernadette Romulo-Puyat won the Excellent Partner Award at the Hyatt Regency Hotel in Osaka at the opening ceremony of the Tourism Expo Japan. The award-giving committee praised the agency's socially advanced measures in the restoration by risking closure and pursuing a coordinated effort to accomplish Boracay's physical, social, environmental, and social recovery.",
      ),
      AwardsModel(
          name:
              "World’s Best Island Beaches in the Condé Nast Traveler 2020 Readers’ Choice Awards",
          imgName: 'awards4',
          caption:
              "Top #2 on World’s Best Island Beaches in the Condé Nast Traveler 2020 Readers’ Choice AwardsWhite Beach on the Malay island of Boracay came in second among the 25 islands that Condé Nast Traveler readers thought about this year and can't wait to go back to. Despite the tourism halt caused by the coronavirus outbreak, the island selections remained in the imaginations of world travelers. "),
      AwardsModel(
          name:
              "Boracay's White Beach ranked 12 spot among TripAdvisor Travelers' Choice 2021",
          imgName: 'awards5',
          caption:
              "The TripAdvisor recognition is all the more heartwarming as sun and beach have always been the country’s best tourism products. Boracay, well known for its White Beach is among the first destinations we opened up, Tourism Secretary Bernadette Romulo-Puyat said."),
    ];
  }

  static List<CultureModel> getculture() {
    return [
      CultureModel(
        name: "Ati-atihan Festival",
        imgName: 'Culture1',
        caption:
            "Boracay Sto. Niño Ati-atihan is celebrated in the most festive way, starts with a fluvial parade of the image of Sto. Niño at the shores of Boracay followed by a High Mass spearheaded by the Parish of the Most Holy Rosary at Balabag Plaza.",
      ),
      
      CultureModel(
        name: "Love Boracay",
        imgName: 'Culture3',
        caption:
            "Laboracay has been rebranded to “Love Boracay” and the focus of the event changed. This weekend is full of events that promotes sustainable tourism.",
      ),
        CultureModel(
        name: "Fiesta De Obreros",
        imgName: 'Culture4',
        caption:
            "This festivity pays tribute to the real wealth of the municipality, the Malaynon workers and St. Joseph the Worker, Malay’s Patron Saint. The highlight is street dancing and merry-making participated by the labor sector, the barangays and the municipal government. The event also features PASADA, a showdown of dance presentations depicting the municipality’s livelihood and source of income of its people. Conceptualized in 2003, Fiesta de Obreros is now known to be among Malay’s attraction as a joyous occasion that brings people together in thanksgiving for the prosperity brought about by their tireless efforts for progress and development.",
      ),
       CultureModel(
        name: "Malay Day",
        imgName: 'Culture5',
        caption:
            " An annual celebration commemorating the formal separation of the municipality of Malay from Buruanga, held every June 15. The celebration is highlighted by various activities such as Discovery Tour, and Paraw Regatta.",
      ),
      CultureModel(
        name: "Paraw",
        imgName: 'Culture2',
        caption:
            "Paraw Sailing is a local sail boat activity. The boats use two outriggers and two sails. Experience the traditional way of sailing and discover the best sites around the island.",
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

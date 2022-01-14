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
        title: "Explore Boracay",
        message:
            'A great path is waiting for you. With Byway Boracay, explore great distinations and discover great deals! The sand and waves of Boracay is waiting for you.',
        imgName: 'Budgeting',
      ),
      OnBoardingContent(
        title: "Browse Your Destination",
        message:
            'Come across establishments and sites that you can navigate with Byway Boracay. Find out how easy and precise our app is.',
        imgName: 'Navigation',
      ),
      OnBoardingContent(
        title: "Practice Sustainable Travel",
        message:
            'Byway Boracay promotes sustainable tourism. With sustainability, going local and low-cost travel can be achieved. Come and contribute!',
        imgName: 'Communication',
      ),
      OnBoardingContent(
        title: 'Build Your Itinerary',
        message:
            "Create your tour plans with ease and flexibility. With Byway Boracay, you're only one click away to a great tour experience!",
        imgName: 'Planning',
      ),
    ];
  }

  static List<ForYouContent> getForyouContents() {
    return [
      ForYouContent(
          name: 'White Beach',
          address: 'Balabag, Malay, Aklan',
          description:
              "White Beach is essentially Boracay Island. As the island's main attraction, this Boracay beach is one of the top tourist spots in the Philippines. Situated in the province of Aklan, White Beach is one of the best beaches in the Philippines and has always been the star of the show in Boracay Island.",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fboracay2.jpeg?alt=media&token=f12dd2b6-4b49-444b-b5cc-e55ca38103a8",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2FBoracay-Island-White-Sand-Beach.jpg?alt=media&token=7294e6ee-fdf6-4a4c-87cd-021242dd3149",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2F94a2dc91-92fe-42d6-abbb-3a2517e9803a.jpg?alt=media&token=2ef659be-bdbb-45a6-96ed-35406561644b"),
      ForYouContent(
          name: "Willy’s Rock",
          address: 'Balabag, Malay, Aklan',
          description:
              "Willy’s Rock is the most photographed landmark in Boracay. Also known to many as the ‘grotto’, it is characterized by a unique cluster of rock formation with a statue of the Virgin Mary. It is located at Station 1 and can be easily seen along the beach. It’s scenic any time of the day, with the clear blue skies or the golden sunset as your backdrop.",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fgroto1%20(1).jpg?alt=media&token=b98232ed-836b-4007-8575-33aefc0cf7a6",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fgroto2.jpeg?alt=media&token=c2c7fed7-9126-40da-96a7-c6b98021b21a",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fgroto3.jpg?alt=media&token=a0395e66-a8ae-4651-80dd-a1c42ff366c2"),
      ForYouContent(
          name: 'Key Hole',
          address: 'Yapak, Malay, Aklan',
          description:
              "This rock formation is located at the northeastern part of Boracay island on Barangay Yapak, at the southern end of the Newcoast property. It features a large opening on a large rock formation that tapers toward the sea. At certain angles, it looks like a dragon taking a sip of water. ",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fstonehedge2.jpg?alt=media&token=47ecf643-fa0a-4043-9ffe-7cbc34d765e5",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fstonehedge3.jpg?alt=media&token=c7ce108e-965b-4000-bb1e-a28ba97e3966",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2FStonehedge1.jpg?alt=media&token=a25c1997-e2e4-4b07-a6c9-71c645014be0"),
      ForYouContent(
          name: 'Mt. Luho',
          address: 'Balabag, Malay, Aklan',
          description:
              "Mt. Luho is Boracay's highest peak that gives you a panoramic view of the island. Once you enter Mt. Luho you'll be greeted by a few animals (monkey's, birds, Tasmanian devil etc.), as Mt. Luho has a mini zoo for tourists to see. You'll be taking just a few stairs to reach the viewing deck and you'll be able to see the whole island. Do note that ​Mt. Luho isn't too high so you won't need any climbing equipment. The peak may be reached by a long walk or a tricycle ride that is always available to take you to the peak's entrance, or maybe try the ATV on the island and pass by Mt. Luho.",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fmtluho3.jpg?alt=media&token=d536a1c4-fe0b-4169-9aa9-efb123226f0e",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fmtluho2.jpeg?alt=media&token=b0a36f45-821e-4cf2-a272-e9222b940571",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fmtluho.jpg?alt=media&token=c030b0c6-bbae-4d0c-8231-298538856822"),
      ForYouContent(
          name: 'Puka Beach',
          address: 'Yapak, Malay, Aklan',
          description:
              "Puka Beach is 800 meters long and fronted by a big cliff with a forest alongside it. At dusk you can see flying foxes (very big bats) flying across the top of the cliff. The sand is coarser than that of White Beach due to the small bits of coral mixed in with it. The beach also is known to have a coast with puka shells, which is where it got its name from.",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fpuka1.jpg?alt=media&token=4c9da265-173e-4462-9700-6e8353a5417f",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fpuka2.jpg?alt=media&token=712f1699-d72e-4aa0-b4f8-183404932906",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fpukkaaa3.jpg?alt=media&token=275838ca-6703-46ef-a918-b3a8ed95e0b7"),
      ForYouContent(
          name: "D'mall Boracay",
          address: 'Balabag, Malay, Aklan',
          description:
              "D’Mall, Boracay’s main open-air mall, has a vibrant street market vibe which people find enjoyable. From Station 1, D’Mall Boracay is just a five-minute tricycle ride. It is also considered as the best commercial place to shop in Boracay; it has various shops, restaurants, and cafes, catering for your needs and tastebuds. ATM machines, banks, pawnshops, and money-changers are also located here. The mall serves as a reference point for meet-ups with booked tour guides and friends as well.",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fdmall2.jpeg?alt=media&token=9fea752c-1599-4065-9981-886565aefb0f",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fdmall3.jpg?alt=media&token=3ca36efe-5034-48e7-82f0-056934a96edb",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fdmall112.jpg?alt=media&token=800df8c4-a0a9-47ec-a827-b70d00207202"),
      ForYouContent(
          name: "Balabag Wetland Park",
          address: 'Balabag, Malay, Aklan',
          description:
              "Balabag Wetland Park, also known as 'Laketown' and Wetland No. 4 in Barangay Balabag, Boracay, has been formally unveiled last October 15, 2018 during Boracay's pre-opening dry run. Key improvements include a 350-meter promenade that will fringe the wetland to further protect the area and allow locals and tourists a recreational amenity. Interpretive signage will be installed at key spots to identify plant species and illustrate how wetlands work. Rain gardens, and a new public plaza and wetland species will also be reintroduced on and at the water's edge.",
          img2:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fwetlandpark2.jpg?alt=media&token=91540086-f3e9-4c7e-b724-489cf4fdbaa8",
          img1:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fwetlandpark1.jpg?alt=media&token=382f5563-5c53-4fd3-9b14-140efaffc162",
          img3:
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/explorepage%2Fwetland3.jfif?alt=media&token=84845ee7-7330-4a35-8122-980a2cf9a954")
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
              "Boracay is famous for its White Beach and the powder-like sand that is unlike any other in the world. The breathtaking sunset view on this side of the island is equally adored that a Boracay holiday would not be complete without witnessing the most photographed subject in the island."),
      HighlightModel(
          name: 'Water Activities',
          imgName: 'Highlight5',
          color: Colors.yellow[700],
          caption:
              "You have to try some of these highly recommended water activities when you're in Boracay. It's a way to get your adrenaline up and kicking! It's also an excellent way to bond with your friends and family.")
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

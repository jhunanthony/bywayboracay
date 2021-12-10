import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Navigation/TopNavBar.dart';

class ToBringPage extends StatefulWidget {
  @override
  State<ToBringPage> createState() => _ToBringPageState();
}

class _ToBringPageState extends State<ToBringPage> {
  List tobringitems = [
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring1.jpg?alt=media&token=473e73a0-0051-441f-8262-811711d01e1c",
      "name": "Eco-Friendly Water Bottle",
      "description":
          "Plastics are already banned in the whole island, so it is advisable to bring your own water tumbler. It’s going to be your perfect companion while on the beach – whether during your activities or simply when you’re out for a stroll.",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring2.jpg?alt=media&token=c7f8aecf-e82b-4236-9a17-9a6cfe01e8b4",
      "name": "Flip-flops",
      "description":
          "The beach is the perfect place to ditch your pair of sneakers and wear your favorite pair of flip-flops. Make sure to bring your most trusted and comfortable pair as it can either make or break your getaway – one that can stand long walks on a sandy shore or a wild night-out!",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring3.jpg?alt=media&token=997c4694-51ba-4742-8865-191ea4a6ee23",
      "name": "Sunglasses",
      "description":
          "Make sure to protect your eyes from the harmful rays of the sun with a pair of sunnies, and look stylish all the same time! While most are made of plastics and metals – there are also those that are made of bamboo which are eco-friendlier especially if you are the type who has the tendency to drop them on the water while parasailing! So choose wisely and get those biodegradable wooden shades!",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring4.png?alt=media&token=ba6f5fce-d27b-4bc8-bf0e-37737ea82a6c",
      "name": "Sunblock",
      "description":
          "Too much exposure from the sun is always a bad idea, so always bring a sunblock that works well with your skin. If you are trying a new product, make sure to test it on yourself before your getaway so you won’t have to deal with allergies and breakouts during your trip! Dermatologists recommend using a SPF30 – better if you can get coral reef-safe sunscreens or those that do not contain oxybenzone, octinoxate and other harmful chemicals! Its extra safer for your skin and for the marine life!",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring5.jpg?alt=media&token=baa0ff53-c831-436d-a749-5d47e294cf92",
      "name": "Swimwear",
      "description":
          "A trip to the beach won’t be complete without those bright and colorful swimsuits! Cover-ups will come in handy as it is still appropriate to have them on while dining on your favorite restaurant. ",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring6.jpg?alt=media&token=cf7c8a22-ea1e-4331-ab1c-2cbc63ecfb70",
      "name": "Dry Bag",
      "description":
          "A dry bag will come in handy when you head out to explore the island. It will keep all of your beach essentials in place, safe and dry! They come in different sizes, but a small one would be enough to carry around the beach.",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring7.jfif?alt=media&token=87d11610-8a11-45a3-b628-c5e1d00e19c9",
      "name": "Camera/Phone",
      "description":
          "A camera is a good way to immortalize moments! If you’re that type of person who wants to just capture some selfies, groufies, and random photos, a phone would be just fine. Just make sure to keep it out of the water since salt water can damage your gadgets.",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Ftobring8.jpg?alt=media&token=8e64cfdb-2d90-4825-9ad7-198f1900556a",
      "name": "Hat/Cap",
      "description":
          "When it’s too hot outside, a hat will keep your skin, hair, and eyes protected from the sun. It’s also a good way to hide your hair if you’re too lazy to fix it! Small or big, it’s one cool beach accessory that will definitely add flare to your OOTDs.",
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 25, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Icon(CupertinoIcons.bag, color: Colors.blue, size: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('To Bring',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: tobringitems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                                child: Image.network(
                                    "${tobringitems[index]['imgName']}",
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover)),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${tobringitems[index]['name']}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${tobringitems[index]['description']}",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

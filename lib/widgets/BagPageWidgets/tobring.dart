
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

  int pageIndex = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: TopNavBar(
            colorbackground: Colors.transparent,
          ),
          body: Container(
              child: Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
            child: Column(
              children: [
                Text(
                  "TO BRING",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                    child: PageView(
                  controller: _controller,
                  //use to updatte page index to rebui,d
                  onPageChanged: (int page) {
                    setState(() {
                      pageIndex = page;
                    });
                  },
                  children: List.generate(
                    tobringitems.length,
                    (index) => Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 20,
                                offset: Offset.zero)
                          ]),
                      child: Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.white.withOpacity(0.3),
                                          Colors.white,
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${tobringitems[index]['name']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Image.network(
                                  "${tobringitems[index]['imgName']}",
                                  height: 300,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${tobringitems[index]['description']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )),

                          //enter button
                        ],
                      ),
                    ),
                  ),
                )),
                //indicator
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        tobringitems.length,
                        (index) => GestureDetector(
                              onTap: () {
                                _controller.animateTo(
                                    MediaQuery.of(context).size.width * index,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                              child: Container(
                                width: 15,
                                height: 15,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 6,
                                        color: pageIndex == index
                                            ? Colors.blue[50]
                                            : Theme.of(context).canvasColor)),
                              ),
                            ))),
              ],
            ),
          ))),
    );

  }
}

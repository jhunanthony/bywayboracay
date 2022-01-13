import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Navigation/TopNavBar.dart';

class LocalFoodPage extends StatefulWidget {
  @override
  State<LocalFoodPage> createState() => _LocalFoodPageState();
}

class _LocalFoodPageState extends State<LocalFoodPage> {
  List tobringitems = [
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Fmuffindd.jpg?alt=media&token=54d86e3c-65ad-427f-bf1e-5e1373d6935f",
      "name": "Calamansi Muffin",
      "description":
          "What is ‘calamansi’ ? (say “kah-lah-manh- see” ) Calamansi is the Filipino lime. Calamansi, the Philippine lime are small,green, round citrus fruits, measuring about quarter of an inch in diameter. They have the tart flavors of a mandarin orange, but are sour as much as they’re sweet.The calamansi also has a piercing sweet citrus scent. This fruit is used as a main ingredient to a very popular sweets in Boracay, the calamansi muffin. The muffin is said to be sweet, sour, soft, and savory at the same time. So try it out!",
    }),
    ({
      "imgName":
"https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Fchicken-binakol-or-chicken-in-coconut-soup-recipe.jpg?alt=media&token=a4e1cabb-516d-45e9-b662-df953f74510d",    
  "name": "BINAKOE/BINAKUL",
      "description":
          "Traditional binakoe is cooked inside a fresh node of bamboo. Native chicken plus onions and lemongrass are added. For the souring agent, aeabihig leaves complete the mix. Think of this dish as similar to the sinigang and might appeal to Tagalog palates.A hot plate of rice plus steamig binakoe then paired with an ice cold soda would be the perfect lunch!",
    }),
    ({
      "imgName":
"https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Fubad-22.jpg?alt=media&token=3baa9590-ab6b-43d4-a8f2-9f96b329a26b",
      "name": "INUBARANG MANOK",
      "description":
          "Do you know that the core of banana stalk (ubad) when cooked in coconut milk can be so good! Native chicken cooked with the said ingredient, gata and lemongrass results in a stew like dish that has a thickish soup. You will love the gata taste, the tenderness of the chicken and the hint of tanglad (lemongrass).",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2F60639307_2322508324695115_6011781293191200768_n.jpg?alt=media&token=e9956e9e-1550-46e0-b2d5-c6772f1c566e",
      "name": "Tinumkan",
      "description":
          "a shrimp mix with local local herbs and spices, grinded and mix together using eosong and hae-o. The mixture is placed into a banana leaf  and cooked in water for 15 to 20 minutes.",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2F7I_everydayfood_chicken_adobo.jpg?alt=media&token=9c91de7c-8d53-4fcb-ae56-78ad983a84bb",
      "name": "Adobo nga may Gata",
      "description":
          "A typical filipino dish with a twist, same process on how to cook adobo but Malaynons used coconut milk instead of soy sauce.",
    }),
    ({
      "imgName":
          "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2F148858635_113107147432735_460560278116641091_n.jpg?alt=media&token=cf11ff3c-92ba-4fbb-83da-edb9ff55c976",
      "name": "Inumoe",
      "description":
          " The inumoe is made of cooked rice (sinaing), yeast and powdered rice. After mixing thoroughly, it is then wrapped in a payaw plant (a family of caladium) and stored for 24 hours. It is best served chilled and tastes like fermented rice.",
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

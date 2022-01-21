
import 'package:flutter/material.dart';


import '../Navigation/TopNavBar.dart';

class LocalProductsWidgetPage extends StatefulWidget {
  @override
  State<LocalProductsWidgetPage> createState() =>
      _LocalProductsWidgetPageState();
}

class _LocalProductsWidgetPageState extends State<LocalProductsWidgetPage> {
  List tobringitems = [
    ({
      "name": 'Dried Mangoes',
      "imgName": 'assets/images/localprod1.jpg',
      "description":
          'Never go home without buying a couple of packs of dried mangoes and other candied fruits. These dried fruit candies will delight anyone who will have the pleasure to savor it. Made from export-quality mangoes from neighboring provinces, the dried mango candies of Boracay is a sure-fire hit as a pasalubong.',
    }),
    ({
      "name": 'HANDMADE BAG',
      "imgName": 'assets/images/localprod2.jpg',
      "description":
          'Boracay’s version of Aklan’s Ati-Atih an on the second Sunday of January wows foreigners with the motley-colored bodily decorations of the dancers grooving to lively music.Made from materials sourced from local farmers and made by the finest local artisans, these bags lend a cool, native look to any outfit. ',
    }),
    ({
      "name": 'SEAFOODS',
      "imgName": 'assets/images/localprod3.jpg',
      "description":
          'Well, not exactly souvenirs, In D’ Talipapa Market, you can not only get bargain prices on your souvenirs, you can also buy freshly-caught seafood – fresh fish, fresh shellfish, lobsters, crabs, and so many more goodies – and have them cooked in the many dampa restaurants in the area.',
    }),
    ({
      "name": 'PUKA SHELLS',
      "imgName": 'assets/images/localprod4.jpg',
      "description":
          ' Boracay has a lot of sources of some of the world’s shiniest puka shells; very rarely do you see Boracay craftsmen putting lacquer on their puka shells for the color and shine. Get a few necklace + bracelet combos for the bros back home!',
    }),
    ({
      "name": 'BEACH DRESSES',
      "imgName": 'assets/images/localprod5.jpg',
      "description":
          'The Island of Boracay has a lot of tropical-inspired beachwear to offer, be it for the conservative or adventurous type of women. Choose from a variety of designs, like Malay-themed dresses, with indigenous patterns, or just standard florals and waves ',
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
                  "Local Products",
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
                                Image.asset(
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

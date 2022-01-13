import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Navigation/TopNavBar.dart';

class LocalEventsWidgetPage extends StatefulWidget {
  @override
  State<LocalEventsWidgetPage> createState() => _LocalEventsWidgetPageState();
}

class _LocalEventsWidgetPageState extends State<LocalEventsWidgetPage> {
  List tobringitems = [
    ({
      "name": 'DRAGON BOAT FESTIVAL',
      "imgName": 'assets/images/dragon.jpg',
      "description":
          'The Dragon Boat Festival includes competitions for teams of men, women, and mixed rowers who race to the finish line using a dragon-inspired, 15-meter-long boat.',
    }),
    ({
      "name": 'ATIATIHAN FESTIVAL',
      "imgName": 'assets/images/atiatihan.jpg',
      "description":
          'Boracay’s version of Aklan’s Ati-Atihan on the second Sunday of January wows foreigners with the motley-colored bodily decorations of the dancers grooving to lively music.',
    }),
    ({
      "name": 'NEW YEAR',
      "imgName": 'assets/images/newyear.jpeg',
      "description":
          'Boracay entertains tourists in ushering in the New Year, just like a renowned tourist attraction must do. Colorful fireworks are set off in the last minutes of December 31 to welcome New Year.',
    }),
    ({
      "name": 'PARAW CUP',
      "imgName": 'assets/images/paraw.jpg',
      "description":
          'Combining a cultural and sports event in one, the International Paraw Cup Challenge showcases locals’ skills in steering the native outrigger boats of the Philippines .',
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
                  "Local Events",
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

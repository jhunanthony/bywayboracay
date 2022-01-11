import 'package:bywayborcay/helper/Utils.dart';
import 'package:bywayborcay/models/OnBoardingModel.dart';
import 'package:bywayborcay/pages/MainPage.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  //call method from utils to local
  List<OnBoardingContent> _content = Utils.getOnBoarding();

  //create index page to track page
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
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Login_Beach.jpg"),
                fit: BoxFit.fitHeight,
              )),
              child: Stack(children: [
                Positioned.fill(
                    child: Container(
                        decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.blue.withOpacity(0.1),
                      Colors.blue.withOpacity(0.3),
                      Colors.blue.withOpacity(0.5),
                      Colors.blue.withOpacity(0.7),
                      Colors.blue,
                    ],
                  ),
                ))),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
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
                          _content.length,
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
                                        child: Image.asset(
                                          "assets/images/Logo_Test.png",
                                          height: 35,
                                          width: 35,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                        'assets/images/${_content[index].imgName}.png'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      _content[index].message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )),

                                //enter button
                                Visibility(
                                  //use this to only show it on the last screen
                                  visible: index == _content.length - 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue, //background
                                        onPrimary: Colors.white, //foreground
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Enter App',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainPage()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      //indicator
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              _content.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      _controller.animateTo(
                                          MediaQuery.of(context).size.width *
                                              index,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeInOut);
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 6,
                                              color: pageIndex == index
                                                  ? Colors.blue[50]
                                                  : Theme.of(context)
                                                      .canvasColor)),
                                    ),
                                  ))),
                      //skip button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, //background
                              onPrimary: Colors.blue, //foreground
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: Container(
                            height: 40,
                            width: 35,
                            alignment: Alignment.center,
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ]))),
    );
  }
}

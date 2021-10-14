import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

class DetailsPage extends StatefulWidget {
  //pass the values
  Items items;

  DetailsPage({this.items});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _imagepageController = PageController(viewportFraction: 0.877);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //show header
              //wrap with stack to add components above images
              Stack(children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,

                  //wrap with stack to overlay other components
                  child: ListView.builder(
                      controller: _imagepageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.items.detailsimages.length,
                      itemBuilder: (BuildContext context, int index) {
                        //show photos here
                        return Row(children: [
                          Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/' +
                                      widget
                                          .items.detailsimages[index].imgName +
                                      '.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  //add gradient
                                  Positioned.fill(
                                    child: Container(
                                        decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.transparent,
                                          widget.items.color.withOpacity(0.3),
                                        ],
                                      ),
                                    )),
                                  ),
                                ],
                              )),
                          //add spacing
                          SizedBox(
                            width: 5,
                          )
                        ]);
                      }),
                ),
                /*Positioned(
                    bottom: 10,
                    left: 20,
                    child: CategoryIcon(
                      iconName: widget.items.iconName,
                      color: widget.items.color,
                      size: 50,
                    )),*/

                //add like button
                Positioned(
                    bottom: 90,
                    right: 20,
                    child: Column(children: [
                      //wrap with gesture detector
                      InkWell(
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.4),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 30,
                              ),
                            )),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Like',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      /*Text(
                        widget.items.likes.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),*/
                    ])),
                //add save button
                Positioned(
                    bottom: 10,
                    right: 20,
                    child: Column(children: [
                      InkWell(
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Save to \nitinerary',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ])),
                //page indicator
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: _imagepageController,
                      count: widget.items.detailsimages.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: widget.items.color,
                          dotColor: Colors.white,
                          dotHeight: 5,
                          dotWidth: 5,
                          spacing: 4.8),
                    ),
                  ),
                )
              ]),
              //show page indicator
              /*Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: SmoothPageIndicator(
                    controller: _imagepageController,
                    count: widget.items.detailsimages.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: widget.items.color,
                        dotColor: Colors.grey[400],
                        dotHeight: 5,
                        dotWidth: 5,
                        spacing: 4.8),
                  ),
                ),
              ),*/
              //show name of item
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  widget.items.name,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
              //Use EXapnding text widget
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: ExpandableText(
                  "       " + widget.items.description,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 4,
                  linkColor: Colors.blue,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.items.opentime,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'min. ₱' + widget.items.pricemin,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
              ),

              //show location here
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.items.address,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              //show map here
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue[200],
                        child: Center(child:Text('map here',))
                        
                        )),
              ),

              //add contact information
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 5,
                    bottom: 5,
                    right: 20,
                  ),
                  child: Text(
                    'Contacts',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),

              //add contacts

              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //column for text call and fb
                    Column(
                      children: [
                        Text(' Call  ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(' Facebook  ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    //column for buttons for call and fb
                    Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          child: Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.blue,
                          ),
                          onTap: () async {
                            String sms = "tel:" + widget.items.contactnumber;
                            if (await canLaunch(sms)) {
                              await launch(sms);
                            } else {
                              throw 'Could not launch $sms';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.circle,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String socialmedia = "fb://facewebmodal/f?href=" +
                                  widget.items.socialmedia;
                              if (await canLaunch(socialmedia)) {
                                await launch(socialmedia);
                              } else {
                                throw 'Could not launch $socialmedia';
                              }
                            }),
                      ],
                    ),
                    //column for email and website
                    Column(
                      children: [
                        Text(' Email  ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(' Website  ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    //column for button email and web
                    Column(
                      children: [
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String mailto = "mailto:" +
                                  widget.items.email +
                                  "?subject=Inquiry&body=Greetings!";
                              if (await canLaunch(mailto)) {
                                await launch(mailto);
                              } else {
                                throw 'Could not launch $mailto';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.web_asset_rounded,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String url = widget.items.website;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),

        //add top nav
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              colorbackground: Colors.transparent,
            )),
      ]),
    ));
  }
}

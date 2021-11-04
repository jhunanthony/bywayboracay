import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//create category page

class ItemsPage extends StatelessWidget {
  //create instance variables
  Category selectedCategory;

  ItemsPage({
    this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    selectedCategory = catSelection.selectedCategory;

    //to activate change notifier on saves
    //SaveService saveService = Provider.of<SaveService>(context, listen: false);

    //access like service
    LikeService likedService = Provider.of<LikeService>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Column(children: [
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(this.selectedCategory.imgName),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Container(
                        decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      this.selectedCategory.color.withOpacity(0.5),
                    ],
                  ),
                ))),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Text(this.selectedCategory.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                ),
              ]),
              // create list builder to show subCategories this.selectedCategory.subCategory.length
              /*child: ListView.builder(
                      padding: EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 80),
                      itemCount: this.selectedCategory.items.length,
                      itemBuilder: (BuildContext ctx, int index) {*/
              Consumer<LoginService>(builder: (context, loginService, child) {
                if (loginService.isUserLoggedIn()) {
                  return Expanded(
                      child: GridView.count(
                          padding: EdgeInsets.only(
                              top: 25, left: 20, right: 20, bottom: 80),
                          shrinkWrap: true,
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                          children: List.generate(
                              this.selectedCategory.items.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                //check if added already or not
                                var itemcat =
                                    this.selectedCategory.items[index];
                                catSelection.items = likedService
                                    .getCategoryFromLikedItems(itemcat);
                                Navigator.of(context).pushNamed('/detailspage');
                              },
                              //user physicalmodel to add shadow in a combined widgets
                              child: Column(children: [
                                Container(
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(this
                                          .selectedCategory
                                          .items[index]
                                          .imgName),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  //stack all descriptions values etc. here
                                  child: Stack(children: [
                                    Positioned.fill(
                                      child: Container(
                                          decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.5),
                                            Colors.black,
                                          ],
                                        ),
                                      )),
                                    ),
                                    //add likes and number of likes
                                    /*Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Column(children: [
                                      //wrap this with gesture detector
                                      Icon(
                                        Icons.bookmark,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(height: 3),
                                      //Use Visibility to hide empty
                                      /*Consumer<SaveService>(
                                          //a function called when notifier changes
                                          builder: (context, save, child) {
                                        return Text(
                                          '${save.items.length}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        );
                                      }),*/
                                    ]),
                                  ),*/
                                    //showname
                                    // add sub cat name
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //wrap to expand if too long
                                            Wrap(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(
                                                    this
                                                        .selectedCategory
                                                        .items[index]
                                                        .name,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ]),

                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                                SizedBox(width: 3),
                                                Wrap(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Text(
                                                        this
                                                            .selectedCategory
                                                            .items[index]
                                                            .itemaddress,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          ]),
                                    )
                                  ]),
                                ),
                                //bottom card
                                Container(
                                  height: 60,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[200],
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          left: 10,
                                          right: 10,
                                          bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //show open time and min price
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Open " +
                                                    this
                                                        .selectedCategory
                                                        .items[index]
                                                        .itemopenTime,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "min. ₱ " +
                                                    this
                                                        .selectedCategory
                                                        .items[index]
                                                        .itempriceMin
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          //show save number
                                          /*Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //wrap this with gesture detector
                                            Icon(
                                              Icons.bookmark,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //wrap this with gesture detector
                                            Text(
                                              this
                                                  .selectedCategory
                                                  .items[index]
                                                  .saves
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        )*/
                                        ],
                                      )),
                                )
                              ]),
                            );
                          })));
                }
                return Center(child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           SizedBox(height: 300,),
                            Text(' Login first to access items!',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 20,
                                )),
                          ]),);
              })
            ]),
            //show Icon
            Positioned(
                top: 125,
                left: 0,
                right: 0,
                child: CategoryIcon(
                  iconName: this.selectedCategory.iconName,
                  color: this.selectedCategory.color,
                  size: 50,
                )),
            //show app bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopNavBar(
                colorbackground: Colors.transparent,
              ),
            ),
          ])),
    );
  }
}

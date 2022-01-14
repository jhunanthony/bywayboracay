import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CategoryIcon.dart';

class CategoryCard extends StatelessWidget {
  Category category;
  Function onCardClick;

  //create a contructor that will populate the category
  CategoryCard({this.category, this.onCardClick});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      GestureDetector(
        onTap: () {
          this.onCardClick();
        },
        child: Container(
          height: 75,
          width: 75,
          color: Colors.transparent,
          child: Stack(children: [
            Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(this.category.imgName),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(2, 2)),
                      ]),
                )),
            Positioned(
                bottom: 0,
                right: 4,
                child: CategoryIcon(
                  color: this.category.color,
                  iconName: this.category.name,
                  hasborder: true,
                  size: 30,
                )),
          ]),
        ),
      ),
      SizedBox(height: 5),
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          this.category.name,
          style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              fontWeight: FontWeight.w400),
        ),
      ),
      SizedBox(height: 5),
    ]);
  }
}

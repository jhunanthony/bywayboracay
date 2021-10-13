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
      SizedBox(height: 5,),
      GestureDetector(
        onTap: () {
          this.onCardClick();
        },
        child: Container(
          height: 80,
          width: 80,
          color: Colors.transparent,
          child: Stack(children: [
            Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  top: 5,
                ),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/' + this.category.imgName + '.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0,
                            offset: Offset(2, 2)),
                      ]),
                )),
            Positioned(
                bottom: 0,
                right: 4,
                child: CategoryIcon(
                  color: this.category.color,
                  iconName: this.category.iconName,
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
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      SizedBox(height: 5),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//icon card to be reusable
class CategoryIcon extends StatelessWidget {
  Color color;
  String iconName;
  double size;
  bool hasborder;

  CategoryIcon(
      {this.color, this.iconName, this.size = 30, this.hasborder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.size,
        width: this.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: this.hasborder == true
              ? Border.all(
                  color: Colors.white,
                  width: 1.5,
                )
              : Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
          color: this.color,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          'assets/icons/' + this.iconName + '.svg',
          color: Colors.white,
          height: this.size * 0.40,
          width: this.size * 0.40,
        ));
  }
}

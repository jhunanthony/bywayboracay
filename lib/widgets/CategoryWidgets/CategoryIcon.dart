import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//icon card to be reusable
class CategoryIcon extends StatelessWidget {
  Color color;
  String iconName;
  double size;

  CategoryIcon({this.color, this.iconName, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.size,
        width: this.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset('assets/icons/' + this.iconName + '.svg', color: Colors.white));
  }
}

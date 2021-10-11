import 'dart:ui';

//This represents the category and holds properties
class Category {
  String name;
  String iconName;
  Color color;
  String imgName;
  List<Category> subCategory;

//Contructor to hydrate the model
  Category(
    {
      this.name,
      this.iconName,
      this.color,
      this.imgName,
      this.subCategory
    }
  );
}

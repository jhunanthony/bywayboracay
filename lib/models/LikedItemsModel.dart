import 'CategoryModel.dart';

//add two properties that will represent selected items
class LikedItem {
  Category category;
  int units;

  LikedItem({
    this.category,
    this.units = 0,
  });
}

import 'CategoryModel.dart';

//add two properties that will represent selected items
class SavedItem {
  Category category;
  int units;

  SavedItem({
    this.category,
    this.units = 0,
  });
}

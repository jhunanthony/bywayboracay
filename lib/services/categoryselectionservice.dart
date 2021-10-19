import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';

class CategorySelectionService {
  Category _selectedCategory;
  Items _items;

  Category get selectedCategory => _selectedCategory;
  set selectedCategory(Category value) {
    _selectedCategory = value;
  }

  Items get items => _items;
  set items(Items value) {
    _items = value;
  }
}

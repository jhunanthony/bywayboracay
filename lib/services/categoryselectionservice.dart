import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:flutter/material.dart';

class CategorySelectionService extends ChangeNotifier {
  Category _selectedCategory;
  Items _items;

  Category get selectedCategory => _selectedCategory;
  set selectedCategory(Category value) {
    _selectedCategory = value;
    notifyListeners();
  }

  Items get items => _items;
  set items(Items value) {
    _items = value;
    notifyListeners();
  }
}

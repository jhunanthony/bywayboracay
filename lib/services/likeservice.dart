//extend with change notifier a class that provide change notif
import 'dart:collection';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/LikedItemsModel.dart';
import 'package:flutter/cupertino.dart';

class LikeService extends ChangeNotifier {
  //this will hold the items being saved
  final List<LikedItem> _items = [];

  //only allow adding items
  UnmodifiableListView<LikedItem> get items => UnmodifiableListView(_items);

  //brodcast that something is changed
  void add(LikedItem item) {
    _items.add(item);
    notifyListeners();
  }

  //if an item is already in saveditem then false the button
  bool isLiked(Items cat) {
    return _items.length > 0
        ? _items.any((LikedItem item) => item.category.catname == cat.catname)
        : false;
  }

  //method to remove item individually
  void remove(LikedItem item) {
    _items.remove(item);
    notifyListeners();
  }

  //method to remove all item on the list
  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  //fetch item out of the likedpage
  Items getCategoryFromLikedItems(Items cat) {
    Items itemcat = cat;
    if (_items.length > 0 &&
        _items.any((LikedItem item) => item.category.catname == cat.catname)) {
      LikedItem likedItem =
          _items.firstWhere((LikedItem item) => item.category.catname == cat.catname);

      if (likedItem != null) {
        itemcat = likedItem.category;
      }
    }

    return itemcat;
  }
}

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
  bool isLiked(Items cat){
    return _items.length > 0? _items.any(
      (LikedItem item) => item.category.name == cat.name) : false;
   
  }
}

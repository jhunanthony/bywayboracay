//extend with change notifier a class that provide change notif
import 'dart:collection';

import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/SavedItemModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/categoryservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';



class SaveService extends ChangeNotifier {
  //this will hold the items being saved
  final List<SavedItem> _items = [];

  //only allow adding items
  UnmodifiableListView<SavedItem> get items => UnmodifiableListView(_items);

  //brodcast that something is changed
  void add(BuildContext context, SavedItem item) async {
    //add locally and then add on firebase
    _items.add(item);

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    Map<String, int> likeMap = Map();
    _items.forEach((SavedItem item) {
      likeMap[item.category.imgName] = (item.category as Items).amount;
    });

    FirebaseFirestore.instance
        .collection('tourist')
        .doc(loginService.loggedInUserModel.uid)
        //user client data as bool to save
        .set({'LikedItems': likeMap}).then((value) {
      notifyListeners();
    });
  }

  //if an item is already in saveditem then false the button
  //recent change here
  bool isSaved(Items cat) {
    return _items.length > 0
        ? _items.any((SavedItem item) => item.category.name == cat.name)
        : false;
  }

  //method to remove item individually
  void remove(
    BuildContext context,
    SavedItem item,
    String imgname,
  ) async {
    //fetch login service
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
   // Items itemref = (item.category as Items);

    /*FirebaseFirestore.instance
        .collection('tourist')
        .doc(loginService.loggedInUserModel.uid)
        .update({
      'LikedItems.${itemref.itemimgName}': FieldValue.delete()
    }).then((value) {
      (item.category as Items).amount = 0;
      _items.remove(item);
      notifyListeners();
    });*/

 


    FirebaseFirestore.instance
        .collection('tourist')
        .doc(loginService.loggedInUserModel.uid)
        //user client data as bool to save
        .set({
      'LikedItems': FieldValue.arrayRemove([
        {"$imgname": "0"}
      ])

    }).then((value) {
      (item.category as Items).amount = 0;
      _items.remove(item);
      notifyListeners();
    });
  }

  //method to remove all item on the list
  void removeAll(BuildContext context) async {
    //fetch login service
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    FirebaseFirestore.instance
        .collection('tourist')
        .doc(loginService.loggedInUserModel.uid)
        .update({'LikedItems': FieldValue.delete()}).then((value) {
      _items.forEach((SavedItem item) {
        (item.category as Items).amount = 0;
      });
      _items.clear();
      notifyListeners();
    });
  }

  //fetch item out of the likedpage
  Items getCategoryFromLikedItems(Items cat) {
    Items itemcat = cat;
    if (_items.length > 0 &&
        _items.any((SavedItem item) => item.category.name == cat.name)) {
      SavedItem likedItem =
          _items.firstWhere((SavedItem item) => item.category.name == cat.name);

      if (likedItem != null) {
        itemcat = likedItem.category;
      }
    }

    return itemcat;
  }

  //create a method to load data
  void loadLikedItemsFromFirebase(BuildContext context) async {
    //clear items if a user logged previously
    if (_items.length > 0) {
      _items.clear();
    }

    //get reference to extract currently logged user
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    CategoryService catService =
        Provider.of<CategoryService>(context, listen: false);
    CategorySelectionService categorySelectionService =
        Provider.of<CategorySelectionService>(context, listen: false);

    //use isuserloggedin as a way to only fetch data from data
    if (loginService.isUserLoggedIn()) {
      FirebaseFirestore.instance
          .collection('tourist')
          //grab doc with the authenticated user
          .doc(loginService.loggedInUserModel.uid)
          //hook up data and snapshot it
          .get()
          .then((DocumentSnapshot snapshot) {
        //extract data

        if (snapshot.exists) {
          Map<String, dynamic> likedItems =
              snapshot.get(FieldPath(['LikedItems']));

          catService.getCategories().forEach((Category cat) {
            cat.items.forEach((Category itemref) {
              //match the keys
              //keys correspond with unique name
              if (likedItems.keys.contains(itemref.imgName)) {
                //keys correspond with unique image name
                var amount = likedItems[itemref.imgName] as int;
                (itemref as Items).amount = amount;

                _items.add(SavedItem(category: itemref));

                //check if currently selected category
                if (categorySelectionService.items != null &&
                    categorySelectionService.items.name == itemref.name) {
                  categorySelectionService.items = itemref;
                }
              }
            });
          });
          notifyListeners();
        }
      });
    }
  }
}
/*var collection =
                FirebaseFirestore.instance.collection('bywayboracay_data');
            var category = collection.doc('categories');

            var data = category as Map;
            var categoriesData = data['categories'] as List<dynamic>;*/



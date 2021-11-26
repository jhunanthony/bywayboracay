import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/CategoryModel.dart';
import '../models/ItemsModel.dart';
import '../models/RatedItemsModel.dart';
import 'categoryselectionservice.dart';
import 'categoryservice.dart';
import 'loginservice.dart';

class RatingService extends ChangeNotifier {
  double ratingval;
  //this will hold the item rated;
  final List<RatedItems> _rateditems = [];
  //only allow adding items
  UnmodifiableListView<RatedItems> get rateditems =>
      UnmodifiableListView(_rateditems);

  //add rated item to database
  void addrateditem(BuildContext context, RatedItems item, ratingval) {
    //add locally and then add on firebase
    _rateditems.add(item);

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    Map<String, int> ratedMap = Map();
    _rateditems.forEach((RatedItems item) {
      ratedMap[item.category.imgName] = (item.category as Items).amount;
    });

    //ADD TO FIREBASE
    FirebaseFirestore.instance
        .collection('ratedItem')
        .doc(loginService.loggedInUserModel.uid)
        //user client data as bool to save
        .set({'RatedItem': ratedMap}).then((value) {
      notifyListeners();
    });

    //update data
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemrating": FieldValue.increment(ratingval)
    }).then((value) {
      notifyListeners();
    });

    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemratingnum": FieldValue.increment(1)
    }).then((value) {
      notifyListeners();
    });
  }


 bool isRated(Items cat) {
    return _rateditems.length > 0
        ? _rateditems.any((RatedItems item) => item.category.name == cat.name)
        : false;
  }

  

//fetch item out of the rating
  Items getCategoryFromRatedItems(Items cat) {
    Items itemcat = cat;
    if (_rateditems.length > 0 &&
        _rateditems.any((RatedItems item) => item.category.name == cat.name)) {
      RatedItems ratedItem = _rateditems
          .firstWhere((RatedItems item) => item.category.name == cat.name);

      if (ratedItem != null) {
        itemcat = ratedItem.category;
      }
    }

    return itemcat;
  }
  //fetch item out of the likedpage

 

  void loadRatedItemsFromFirebase(BuildContext context) {
    //clear items if a user logged previously
    if (_rateditems.length > 0) {
      _rateditems.clear();
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
          .collection('ratedItem')
          //grab doc with the authenticated user
          .doc(loginService.loggedInUserModel.uid)
          //hook up data and snapshot it
          .get()
          .then((DocumentSnapshot snapshot) {
        //extract data

        Map<String, dynamic> ratedItems =
            snapshot.get(FieldPath(['RatedItem']));

        catService.getCategories().forEach((Category cat) {
          cat.items.forEach((Category itemref) {
            //match the keys
            //keys correspond with unique name
            if (ratedItems.keys.contains(itemref.imgName)) {
              //keys correspond with unique image name
              var amount = ratedItems[itemref.name] as int;
              (itemref as Items).amount = amount;

              _rateditems.add(RatedItems(category: itemref));

              //check if currently selected category
              if (categorySelectionService.items != null &&
                  categorySelectionService.items.name == itemref.name) {
                categorySelectionService.items = itemref;
              }
            }
          });
        });
        notifyListeners();
      });
    }
  }

  /*List<Category> _ratings = [];

  //create getter to make it encapsulated
  List<Category> getRatings() {
    return _ratings;
  }

  //create a method that fetched the data initially
  Future<void> getRatingsCollectionFromFirebase(
      BuildContext context, RatedItems item) async {
    Category itemref = item.category as Items;
    //if the firebase is initialize
    //retrieve an instance from cloud

    FirebaseFirestore.instance
        .collection('ratings')
        //grab doc with the authenticated user
        .doc('${itemref.itemcategoryName}')
        //hook up data and snapshot it
        .get()
        .then((DocumentSnapshot snapshot) {});
  }*/
  //method to add rating
  /*void rateItem(BuildContext context, RatedItems item) {
    /*var collection = FirebaseFirestore.instance.collection('bywayboracay_data');
    var category = collection.doc('categories');

    var data = category as Map;
    var categoriesData = data['categories'] as List<dynamic>;

    var dataset = categoriesData as Map;
    var itemcategoriesData = dataset['items'] as List<dynamic>;*/
    Category itemref = item.category as Items;

    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${itemref.itemcategoryName}')
        .update({"${itemref.name}.itemrating": FieldValue.increment(1)});
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${itemref.itemcategoryName}')
        .update({"${itemref.name}.itemratingnum": FieldValue.increment(1)});
  }*/
}

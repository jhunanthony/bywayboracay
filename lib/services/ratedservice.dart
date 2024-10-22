import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/CategoryModel.dart';
import '../models/ItemsModel.dart';
import '../models/RatedItemsModel.dart';
import '../models/UserLogInModel.dart';
import 'categoryselectionservice.dart';
import 'categoryservice.dart';
import 'loginservice.dart';

class RatingService extends ChangeNotifier {
  double ratingval;
  String commentval;

  //this will hold the item rated;
  final List<RatedItems> _rateditems = [];
  //only allow adding items
  UnmodifiableListView<RatedItems> get rateditems =>
      UnmodifiableListView(_rateditems);

  //add rated item to database
  void addrateditem(
      BuildContext context, RatedItems item, ratingval, commentval) async {
    //add locally and then add on firebase
    _rateditems.add(item);

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;

    String userImg = userModel != null ? userModel.photoUrl : '';
    String userName = userModel != null ? userModel.displayName : '';

    String userId = userModel != null ? userModel.uid : '';

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

    //update data on itemrating
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemrating": FieldValue.increment(ratingval)
    }).then((value) {
      notifyListeners();
    });
    //update data on itemratingnum
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemratingnum": FieldValue.increment(1)
    }).then((value) {
      notifyListeners();
    });
    //set comments

    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.sets": FieldValue.arrayUnion([
        {
          "username": userName,
          "userimg": userImg,
          "rating": ratingval,
          "comment": commentval,
          "uid": userId
        }
      ])
    }).then((value) {
      notifyListeners();
    });
  }

  //add record to firebase
  void addrecord(
    BuildContext context,
    RatedItems item,
  ) async {
    //update data on itemrating
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemrating": FieldValue.increment(0)
    }).then((value) {
      notifyListeners();
    });
    //update data on itemratingnum
    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({
      "${item.category.name}.itemratingnum": FieldValue.increment(0)
    }).then((value) {
      notifyListeners();
    });
    //set comments

    FirebaseFirestore.instance
        .collection('ratings')
        .doc('${item.category.itemcategoryName}')
        .update({"${item.category.name}.sets": FieldValue.arrayUnion([])}).then(
            (value) {
      notifyListeners();
    });
  }

  //add record to firebase
  void removerecord(
    BuildContext context,
    String imgname,
    String userId,
    RatedItems item,
  ) async {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //Items itemref = (item.category as Items);
    /*FirebaseFirestore.instance
        .collection('ratedItem')
        .doc(userId)
        .update({'RatedItem.$imgname': FieldValue.delete()}).then((value) {
      (item.category as Items).amount = 0;
      _rateditems.remove(item);
      notifyListeners();
    });*/

    FirebaseFirestore.instance.collection('ratedItem').doc(userId)
        //user client data as bool to save
        .set({
      'RatedItem': FieldValue.arrayRemove([
        {"$imgname": "0"}
      ])
    }).then((value) {
      _rateditems.remove(item);
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
      RatedItems ratedItems = _rateditems
          .firstWhere((RatedItems item) => item.category.name == cat.name);

      if (ratedItems != null) {
        itemcat = ratedItems.category;
      }
    }

    return itemcat;
  }
  //fetch data

  void loadRatedItemsFromFirebase(BuildContext context) async {
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

        if (snapshot.exists) {
          Map<String, dynamic> ratedItems =
              snapshot.get(FieldPath(['RatedItem']));

          catService.getCategories().forEach((Category cat) {
            cat.items.forEach((Category itemref) {
              //match the keys
              //keys correspond with unique name
              if (ratedItems.keys.contains(itemref.imgName)) {
                //keys correspond with unique image name
                var amount = ratedItems[itemref.imgName] as int;
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
        }
      });
    }
  }
}

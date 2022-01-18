/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AddItemService extends ChangeNotifier {
  //add record to firebase
  void addrateditem(
    BuildContext context,
  ) async {
    List items = [];

    items.add(
      ({
        "item1": "data",
        "item2": "data",
        "item3": "data",
        "itemimages": [
          ({
            "images1": "data",
          }),
          ({
            "images1": "data",
          })
        ]
      }),
    );
    FirebaseFirestore.instance.collection('Testadd').doc("AddItemtest").update({
      "Itemadd": [
        ({
          "cat1": "new",
          "cat2": "new",
          "cat3": "new",
          "item": FieldValue.arrayUnion(items)
        })
      ]
    }).then((value) {
      notifyListeners();
    });
  }
}
*/

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/RatedItemsModel.dart';

class AddItemService extends ChangeNotifier {
  //add record to firebase
  void addrecord(
    BuildContext context,
  ) {
    //update data on itemrating
    FirebaseFirestore.instance.collection('Testadd').doc("AddItemtest").update({
      "Itemadd": FieldValue.arrayUnion([
        ({
          "cat1": "new",
          "cat2": "new",
          "cat3": "new",
          "item": [
            ({
              "item1": "data",
              "item2": "data",
              "item3": "data",
              "itemimages": [
                ({
                  "images1": "data",
                }),
                ({
                  "images1": "data",
                })
              ]
            })
          ]
        })
      ])
    }).then((value) {
      notifyListeners();
    });

    //set comments
  }
}*/

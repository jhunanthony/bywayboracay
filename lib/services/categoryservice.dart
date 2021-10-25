import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  FirebaseFirestore _instance;

  List<Category> _categories = [];

  //create getter to make it encapsulated
  List<Category> getCategories() {
    return _categories;
  }

  //create a method that fetched the data initially
  Future<void> getCategoriesCollectionFromFirebase() async {
    //if the firebase is initialize
    //retrieve an instance from cloud
    _instance = FirebaseFirestore.instance;
    //collect collection reference and pull it from instance collection call
    CollectionReference categories = _instance.collection('bywayboracay_data');

    //out of this collection fetch a
    DocumentSnapshot snapshot = await categories.doc('categories').get();
    //call the data

    var data = snapshot.data() as Map;
    var categoriesData = data['categories'] as List<dynamic>;

    //loop on collection and map each object
    categoriesData.forEach((catData) {
      //convert each catData into the appropriatemodel

      _categories.add(Category.fromJson(catData));
    });
  }
}

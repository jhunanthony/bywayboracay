//this is a temporary mock data generator

import 'package:bywayborcay/models/CategoryModel.dart';

import 'AppColors.dart';
import 'AppIcons.dart';

class Utils {
  //create static method that will return categories with data
  static List<Category> getMockedCategory() {
    return [
      Category(
      color: AppColors.ToStayColor,
      name: 'To Stay',
      imgName: 'Test_Image_1',
      iconName: AppIcons.ToStayIcon,
      subCategory:[]
      ),
      Category(
      color: AppColors.ToEatandDrinkColor,
      name: 'To Eat & Drink',
      imgName: 'Test_Image_2',
      iconName: AppIcons.ToEatandDrinkIcon,
      subCategory:[]
      ),
      Category(
      color: AppColors.ToSeeColor,
      name: 'To See',
      imgName: 'Test_Image_3',
      iconName: AppIcons.ToSeeIcon,
      subCategory:[]
      ),
      Category(
      color: AppColors.ToDoColor,
      name: 'To Do',
      imgName: 'Test_Image_4',
      iconName: AppIcons.ToDoIcon,
      subCategory:[]
      ),
    ];
  }
}

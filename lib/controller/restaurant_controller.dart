import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RestaurantController extends ChangeNotifier {
  bool toggleSearchbar = false;

  void ontoggleSearchbar() {
    toggleSearchbar = !toggleSearchbar;
    notifyListeners();
  }

  String _categoryKey = "All";
  // ignore: unnecessary_getters_setters
  String get categoryKey => _categoryKey;

  String _userImageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/31f9j3A3xKasyUMMsuIQO8/6a8708add4cb4505b65b1cee3f2e6996/9db2e04eb42b427f4968ab41009443b906e4eabf-people_men-min.jpg?fit=fill&w=368&h=207";
  // ignore: unnecessary_getters_setters
  String get userImgUrl => _userImageUrl;

  Map<String, dynamic> _categoryList = {
    "All": "assets/category/all.png",
    "Fast food": "assets/category/fast-food.png",
    "Pizza": "assets/category/pizza.png",
    "Bakery": "assets/category/bakery.png",
    "Drinks": "assets/category/drinks.png",
  };
  // ignore: unnecessary_getters_setters
  Map get categoryList => _categoryList;

  onClickCategory({required String currentKey}) {
    _categoryKey = currentKey;
    notifyListeners();
  }
}

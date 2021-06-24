import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VendersController extends ChangeNotifier {
  String _categoryKey = "All";
  // ignore: unnecessary_getters_setters
  String get categoryKey => _categoryKey;

  String _userImageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/31f9j3A3xKasyUMMsuIQO8/6a8708add4cb4505b65b1cee3f2e6996/9db2e04eb42b427f4968ab41009443b906e4eabf-people_men-min.jpg?fit=fill&w=368&h=207";
  // ignore: unnecessary_getters_setters
  String get userImgUrl => _userImageUrl;

  Map<String, dynamic> _categoryList = {
    "All": null,
    "Fast food": "assets/foods/pizzapieces.png",
    "Bakery": "assets/foods/pancake.png",
    "Drinks": "assets/foods/beverage.png",
  };
  // ignore: unnecessary_getters_setters
  Map get categoryList => _categoryList;

  onClickCategory({required String currentKey}) {
    _categoryKey = currentKey;
    notifyListeners();
  }
}

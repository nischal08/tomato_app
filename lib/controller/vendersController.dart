import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VendersController extends ChangeNotifier {
 
  String _categoryKey = "All";
  // ignore: unnecessary_getters_setters
  String get categoryKey => _categoryKey;

  String _userImageUrl =
      "https://scontent.fktm8-1.fna.fbcdn.net/v/t1.6435-9/122777514_4658406440867560_8980358279672578081_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=lDDUaUO9kIUAX8vRKJ1&_nc_ht=scontent.fktm8-1.fna&oh=d37fe1fa97843bc6248ae4f2699602f1&oe=60CCEA84";
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

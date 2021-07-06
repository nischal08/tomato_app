import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeController extends ChangeNotifier {
  int currentTabIndex = 0;

  void onChangeTabView(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  var bottomNavItemData = {
    Icon(Icons.food_bank_outlined): 'Restaurant',
    Icon(Icons.fastfood_outlined): 'Food',
    Icon(CupertinoIcons.cart): 'Cart',
  };
}

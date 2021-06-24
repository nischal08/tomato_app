import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/screens/food_screen.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/venders_list_screen.dart';

class HomeController extends ChangeNotifier {
  int widgetIndex = 0;
  // bool likeBtnFlag = false;

  // onClickLikeBtn() {
  //   likeBtnFlag = !likeBtnFlag;
  //   notifyListeners();
  // }

  onChangeWidget(int index) {
    widgetIndex = index;
    notifyListeners();
  }

  List _screensList = [
    VendersListScreen(),
    FoodScreen(),
    CartScreen(),
  ];
  // ignore: unnecessary_getters_setters
  List get screensList => _screensList;

  // ignore: unnecessary_getters_setters
  set screensList(List value) => _screensList = value;

  var bottomNavItemData = {
    Icon(Icons.food_bank_outlined): 'Restaurant',
    Icon(Icons.fastfood_outlined): 'Food',
    Icon(Icons.local_dining_outlined): 'Order',
  };

  int _bottomNavIndex = 0;
  // ignore: unnecessary_getters_setters
  int get bottomNavIndex => _bottomNavIndex;

  // ignore: unnecessary_getters_setters
  set bottomNavIndex(int value) => _bottomNavIndex = value;

  onBottomNavClick(int index) {
    widgetIndex = 0;

    bottomNavIndex = index;
    notifyListeners();
  }
}

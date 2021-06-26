import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/screens/food_screen.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/resturant_list_screen.dart';

class TabNavigator extends StatelessWidget {
 late HomeController _homeControllerState;
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  TabNavigator({required Key key, required this.navigatorKey, required this.tabItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _homeControllerState = Provider.of<HomeController>(context);
   late Widget child;

    if (tabItem == "Page1")
      child = ResturantListScreen();
    else if (tabItem == "Page2")
      child = FoodScreen();
    else if (tabItem == "Page3") child = CartScreen();

    return Container(
child:child,      
      
    );
  }
}

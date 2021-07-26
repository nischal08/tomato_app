import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/food_screen.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/screens/detail_screen.dart';

import 'package:tomato_app/screens/restaurants_screen.dart';
import 'package:tomato_app/screens/restaurant_menu.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  late HomeController _homeController;
  Future<bool> _willPopCallback(context) async {
    //  await showDialog or Show add banners or whatever
    // then
    return false;
   
  }

  @override
  Widget build(BuildContext context) {
    _homeController = Provider.of<HomeController>(context, listen: false);
    Map<String, Widget Function(BuildContext)> _routeMap = {
      CartScreen.routeName: (context) => CartScreen(),
      RestaurantMenu.routeName: (context) => RestaurantMenu(),
      RestaurantsScreen.routeName: (context) => RestaurantsScreen(),
      DetailScreen.routeName: (context) => DetailScreen(),
      FoodScreen.routeName: (context) => FoodScreen(),
    };

    return WillPopScope(
      onWillPop: ()=>_willPopCallback(context),
      child: CupertinoTabScaffold(
    
        resizeToAvoidBottomInset: true,
        tabBar: CupertinoTabBar(
          onTap: (index) {
            _homeController.onChangeTabView(index);
          },
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColorDark.withOpacity(0.4),
          items: [
            for (var key in _homeController.bottomNavItemData.keys)
              BottomNavigationBarItem(
                // activeIcon: Icon(Icons.restaurant),
                icon: key,
                // label: _homeController.bottomNavItemData[key],
              ),
          ],
        ),
        tabBuilder: (context, _) {
          switch (_homeController.currentTabIndex) {
            case 0:
              return CupertinoTabView(
                routes: _routeMap,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: RestaurantsScreen(),
                  );
                },
              );
            case 1:
              return CupertinoTabView(
                routes: _routeMap,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: FoodScreen(),
                  );
                },
              );
            case 2:
              return CupertinoTabView(
                routes: _routeMap,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: CartScreen(),
                  );
                },
              );
            default:
              return CupertinoTabView(
                routes: _routeMap,
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: RestaurantsScreen(),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

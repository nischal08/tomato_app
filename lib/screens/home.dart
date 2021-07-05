import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/food_screen.dart';

import 'package:tomato_app/screens/resturant_list_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  HomeController? _homeControllerState;
  @override
  Widget build(BuildContext context) {
    _homeControllerState = Provider.of<HomeController>(context);

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          // border: Border(
          //     top: BorderSide(
          //         color: Colors.grey, width: 0.5, style: BorderStyle.solid)),
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColorDark.withOpacity(0.4),
          items: [
            for (var key in _homeControllerState!.bottomNavItemData.keys)
              BottomNavigationBarItem(
                icon: key,
                label: _homeControllerState!.bottomNavItemData[key],
              ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: ResturantListScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: FoodScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: CartScreen());
                },
              );
            default:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: ResturantListScreen());
                },
              );
          }
        }
        // extendBodyBehindAppBar: true,
        // body: IndexedStack(
        //   index: _homeControllerState!.widgetIndex,
        //   children: [
        //     _homeControllerState!.screensList[_homeControllerState!.bottomNavIndex],
        //     RestaurantMenu(),
        //     ProductDetailScreen(),
        //   ],
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 8,
        //   currentIndex: _homeControllerState!.bottomNavIndex,
        //   items: [
        //     for (var key in _homeControllerState!.bottomNavItemData.keys)
        //       BottomNavigationBarItem(
        //         icon: key,
        //         label: _homeControllerState!.bottomNavItemData[key],
        //       ),
        //   ],
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   unselectedItemColor:  Theme.of(context).primaryColorDark.withOpacity(0.4),
        //   onTap: _homeControllerState!.onBottomNavClick,
        // ),
        );
  }
}

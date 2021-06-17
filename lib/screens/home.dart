import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/screens/product_detail_screen.dart';

import 'package:tomato_app/screens/vender_menu.dart';

class HomeScreen extends StatelessWidget {
    static const routeName = "/";
  HomeController? _homeControllerState;
  @override
  Widget build(BuildContext context) {
    _homeControllerState = Provider.of<HomeController>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        index: _homeControllerState!.widgetIndex,
        children: [
          _homeControllerState!.screensList[_homeControllerState!.bottomNavIndex],
          VenderMenu(),
          ProductDetailScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        currentIndex: _homeControllerState!.bottomNavIndex,
        items: [
          for (var key in _homeControllerState!.bottomNavItemData.keys)
            BottomNavigationBarItem(
              icon: key,
              label: _homeControllerState!.bottomNavItemData[key],
            ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor:  Theme.of(context).primaryColorDark.withOpacity(0.4),
        onTap: _homeControllerState!.onBottomNavClick,
      ),
    );
  }
}

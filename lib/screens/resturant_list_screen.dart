import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/restaurant_controller.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';

import '../widgets/restaurant_card.dart';

// ignore: must_be_immutable
class ResturantListScreen extends StatelessWidget {
  late TextTheme _themeData;
  late RestaurantController _restaurantControllerState;
  late HomeController _homeControllerState;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _restaurantControllerState = Provider.of<RestaurantController>(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).canvasColor,
      body: _body(
        context,
      ),
    );
  }

  Widget _body(
    context,
  ) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _userInfo(context),
            SizedBox(
              height: 25,
            ),
            _search(context),
            SizedBox(
              height: 20,
            ),
            _category(
              context,
            ),
            SizedBox(
              height: 10,
            ),
            _vender(),
          ],
        ),
      ),
    );
  }

  Widget _vender() {
    return Expanded(
      child: ListView(
        children: [
          for (int i = 0; i < 8; i++)
            GestureDetector(
              onTap: () {
                _homeControllerState.onChangeWidget(1);
              },
              child: RestaurantCard(
                  // favFood: "Pizza",
                  // title: "PizzaHut",
                  // rating: 4.5,
                  // networkUrl: 'assets/venders/pizzahut.png',
                  ),
            ),
        ],
      ),
    );
  }

  _userInfo(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _greeting(context),
          _userProfileImg(),
        ],
      ),
    );
  }

  _userProfileImg() {
    return Container(
      height: 45,
      width: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          _restaurantControllerState.userImgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _greeting(context) {
    return RichText(
      text: TextSpan(
        text: "Good Morning, ",
        style: _themeData.headline6,
        children: [
          TextSpan(
            text: "Nischal",
            style: _themeData.headline6!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  _search(context) {
    return Consumer<RestaurantController>(
      builder: (context, resturantCont, _) => 
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: resturantCont.toggleSearchbar
            ? _searchBar(context)
            : _searchButtonTitle(),
      ),
    );
  }

  Widget _searchButtonTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _searchTitle(),
        CustomIconButton(
          icon: Icons.search,
          onPressed: () => _restaurantControllerState.ontoggleSearchbar(),
        )
      ],
    );
  }

  TextField _searchBar(context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
          color: kColorLightGrey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: kColorLightGrey!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: kColorLightGrey!.withOpacity(0.8), width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 1.2),
        ),
      ),
    );
  }

  _searchTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Find your", style: _themeData.headline5),
        Text("favourite foods", style: _themeData.headline6),
      ],
    );
  }

  Widget _category(
    context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 70,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        for (var key in _restaurantControllerState.categoryList.keys)
          _eachCategory(
            context,
            label: key,
            assetUrl: _restaurantControllerState.categoryList[key],
          ),
      ]),
    );
  }

  Widget _eachCategory(
    context, {
    String? assetUrl,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        _restaurantControllerState.onClickCategory(currentKey: label);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 2, bottom: 3),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            boxShadow: [kBoxShadowMeduimChipCard],
            borderRadius: BorderRadius.circular(15),
            color: _restaurantControllerState.categoryKey == label
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor),
        child: Row(
          children: [
            assetUrl == null
                ? SizedBox()
                : SizedBox(
                    height: 30,
                    child: Image.asset(
                      assetUrl,
                    ),
                  ),
            SizedBox(
              width:
                  (assetUrl == null || label == "Bakery" || label == "Drinks")
                      ? 0
                      : 5,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: _restaurantControllerState.categoryKey == label
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/restaurant_controller.dart';
import 'package:tomato_app/screens/restaurant_menu.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';

import '../widgets/restaurant_card.dart';

// ignore: must_be_immutable
class RestaurantListScreen extends StatelessWidget {
  static const routeName = '/restaurant-list';
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
              height: 15,
            ),
            _category(
              context,
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: _vender(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vender(context) {
    return ListView(
      children: [
        SizedBox(
          height: 5,
        ),
        for (int i = 0; i < 8; i++)
          GestureDetector(
            onTap: () {
              // _homeControllerState.onChangeWidget(1);
              Navigator.pushNamed(
                  context,
                 RestaurantMenu.routeName);
            },
            child: RestaurantCard(
                // favFood: "Pizza",
                // title: "PizzaHut",
                // rating: 4.5,
                // networkUrl: 'assets/venders/pizzahut.png',
               
                ),
          ),
      ],
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
      builder: (context, resturantCont, _) => Container(
        height: 50,
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
          elevation: 1,
          icon: Icons.search,
          onPressed: () => _restaurantControllerState.ontoggleSearchbar(),
        )
      ],
    );
  }

  TextField _searchBar(context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Search",
        contentPadding: EdgeInsets.only(top: 5),
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
        Text(
          "Find your",
          style: _themeData.headline6!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          "favourite foods",
          style: _themeData.subtitle1!.copyWith(fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  Widget _category(
    context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      height: 100,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        for (var key in _restaurantControllerState.categoryList.keys)
          Transform.translate(
            offset: Offset(
                0, _restaurantControllerState.categoryKey == key ? -10 : 0),
            child: Container(
              padding: EdgeInsets.only(top: 10),
              margin: const EdgeInsets.only(right: 30),
              child: _eachCategory(
                context,
                label: key,
                assetUrl: _restaurantControllerState.categoryList[key],
              ),
            ),
          ),
      ]),
    );
  }

  Widget _eachCategory(
    context, {
    required String assetUrl,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        _restaurantControllerState.onClickCategory(currentKey: label);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2, bottom: 3),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
                // boxShadow: [kBoxShadowMeduimChipCard],
                borderRadius: BorderRadius.circular(25),
                color: _restaurantControllerState.categoryKey == label
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor),
            child: SizedBox(
              height: 32,
              child: Image.asset(
                assetUrl,
                fit: BoxFit.fitHeight,
                color: _restaurantControllerState.categoryKey == label
                    ? kColorWhiteText
                    : kColorBlackText,
              ),
            ),
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: kColorBlackText.withOpacity(0.6)
                    // color: _restaurantControllerState.categoryKey == label
                    //     ? Colors.white
                    //     : Colors.black
                    ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/homeController.dart';
import 'package:tomato_app/controller/vendersController.dart';
import 'package:tomato_app/widgets/custom_icon_button.dart';
import 'package:tomato_app/widgets/custom_widgets.dart';
import 'package:tomato_app/widgets/product_card.dart';

// ignore: must_be_immutable
class VendersScreen extends StatelessWidget {
  var _theme;
  late TextTheme _themeData;
  late VendersController _restaurantControllerState;
  late HomeController _homeControllerState;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _restaurantControllerState = Provider.of<VendersController>(context);
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
            _userInfo(),
            SizedBox(
              height: 25,
            ),
            _search(),
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
              child: ProductCard(
                favFood: "Pizza",
                venderName: "PizzaHut",
                rating: 4.5,
                assetUrl: 'assets/venders/pizzahut.png',
              ),
            ),
        ],
      ),
    );
  }

  _userInfo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _greeting(),
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
        child: Image.network(_restaurantControllerState.userImgUrl),
      ),
    );
  }

  Widget _greeting() {
    return RichText(
      text: TextSpan(
        text: "Good Morning, ",
        style: _themeData.headline6,
        children: [
          TextSpan(
            text: "Nischal",
            style: _themeData.headline6!.copyWith(color: darkRed),
          ),
        ],
      ),
    );
  }

  _search() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _searchTitle(),
          CustomIconButton(
            icon: Icons.search_outlined,
          ),
        ],
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
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: 10,vertical: 10
      ),
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
        margin: EdgeInsets.only(right: 10,top: 2, bottom: 3),
        padding: EdgeInsets.symmetric(
          horizontal: 20,vertical: 10
        ),
        decoration: BoxDecoration(
          boxShadow: [
            kBoxShadowSmallChipCard
          ],
          borderRadius: BorderRadius.circular(15),
          color: _restaurantControllerState.categoryKey == label
              ? lightRed
              : _theme.cardColor,
        ),
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

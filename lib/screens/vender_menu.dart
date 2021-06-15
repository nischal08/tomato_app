import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/homeController.dart';
import 'package:tomato_app/widgets/product_card.dart';

import 'home.dart';

class VenderMenu extends StatelessWidget {
  late HomeController _homeControllerState;
  var _theme;
  late TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _theme = Theme.of(context);
    _homeControllerState = Provider.of<HomeController>(context);
    return _body(context);
  }

  Widget _body(context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _text(),
            SizedBox(
              height: 30,
            ),
            _venderInfo(),
            SizedBox(
              height: 25,
            ),
            _vender(context),
          ],
        ),
      ),
    );
  }

  Widget _vender(context) {
    return Expanded(
      child: ListView(
        children: [
          for (int i = 0; i < 8; i++)
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _homeControllerState.onChangeWidget(2),
                  child: ProductCard(
                    favFood: "Mixed Pizza",
                    venderName: "Pepperoni Pizza",
                    rating: 4.5,
                    assetUrl: 'assets/foods/polopizza.png',
                    price: 650,
                    productPadding: 12,
                    priceColor: null,
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 1,
                  child: GestureDetector(
                      onTap: () async {
                        await _homeControllerState.onBottomNavClick(2);
                        Get.to(
                          Home(),
                        );
                      },
                      child: _addtoCart(context)),
                ),
                Positioned(
                  right: 45,
                  bottom: 30,
                  child: _favBtn(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _favBtn() {
    return GestureDetector(
      onTap: () {
        _homeControllerState.onClickLikeBtn();
      },
      child: Icon(
        Icons.favorite,
        size: 20,
        color: _homeControllerState.likeBtnFlag
            ? lightRed
            : lightBrown,
      ),
    );
  }

  Widget _addtoCart(context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: lightRed!.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        size: 18,
        color: Theme.of(context).cardColor,
      ),
    );
  }

  _text() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(),
          _backBtn(),
        ],
      ),
    );
  }

  GestureDetector _backBtn() {
    return GestureDetector(
      onTap: () => _homeControllerState.onChangeWidget(0),
      child: Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: lightGrey,
      ),
    );
  }

  _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose what you", style: _themeData.headline4),
        SizedBox(height:5 ,),
        Text("want to eat today", style: _themeData.headline5),
      ],
    );
  }

  Widget _venderInfo() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [kBoxShadowBigCard],
          borderRadius: BorderRadius.circular(20),
          color: _theme.cardColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        padding: EdgeInsets.only(
          left: 15,
          top: 5,
          bottom: 5,
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _venderLogo(),
            _venderName(),
            SizedBox(
              width: 55,
            ),
          ],
        ));
  }

  Widget _venderLogo() {
    return SizedBox(
      height: 55,
      width: 55,
      child: Image.asset(
        'assets/venders/pizzahut.png',
      ),
    );
  }

  Widget _venderName() {
    return Text(
      "PizzaHut",
      style: _themeData.headline6,
    );
  }
}

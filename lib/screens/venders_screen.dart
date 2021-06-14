import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/constant/customColor.dart';
import 'package:tomato_app/controller/homeController.dart';
import 'package:tomato_app/controller/vendersController.dart';
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
    return _body();
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _userInfo(),
            SizedBox(
              height: 35,
            ),
            _search(),
            SizedBox(
              height: 30,
            ),
            _category(),
            SizedBox(
              height: 20,
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
        style: _themeData.subtitle1,
        children: [
          TextSpan(
            text: "Nischal",
            style: _themeData.subtitle2,
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
          CustomIcon(
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

  Widget _category() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      height: 50,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        for (var key in _restaurantControllerState.categoryList.keys)
          _eachCategory(
            label: key,
            assetUrl: _restaurantControllerState.categoryList[key],
          ),
      ]),
    );
  }

  Widget _eachCategory({
    String? assetUrl,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        _restaurantControllerState.onClickCategory(currentKey: label);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _restaurantControllerState.categoryKey == label
              ? CustomColors.lightRed
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
              style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
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

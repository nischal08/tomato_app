import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/products.dart';
import 'package:tomato_app/models/product.dart';
import 'package:tomato_app/widgets/product_card.dart';

class RestaurantMenu extends StatefulWidget {
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  late Products _productContr;
  // bool isInit = false;
  late HomeController _homeControllerState;

  var _theme;

  late TextTheme _themeData;

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (!isInit) {
  //     _productContr = Provider.of<Products>(context);
  //   }
  //   isInit = true;
  // }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _theme = Theme.of(context);
    _homeControllerState = Provider.of<HomeController>(context, listen: false);
    final Products productData = Provider.of<Products>(context);
    return _body(context, productData);
  }

  Widget _body(context, productData) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _customAppbar(),
            SizedBox(
              height: 20,
            ),
            _venderInfo(),
            _productList(context, productData),
          ],
        ),
      ),
    );
  }

  Widget _productList(context, Products productData) {
    return Expanded(
      child: ListView.builder(
        itemCount: productData.items.length,
        itemBuilder: (context, index) =>
            ChangeNotifierProvider<Product>.value(
          value: productData.items[index],
          child: ProductCard(),
        ),
      ),
    );
  }

  _customAppbar() {
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
        color: kColorLightGrey,
      ),
    );
  }

  _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose what you", style: _themeData.headline4),
        SizedBox(
          height: 5,
        ),
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
        height: 90,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tomato_app/controller/homeController.dart';
import 'package:tomato_app/controller/orderController.dart';
import 'package:tomato_app/widgets/buy_and_add_to_cart_button.dart';
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  late HomeController _homeControllerState;
  late OrderController _orderControllerState;
  late TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _orderControllerState = Provider.of<OrderController>(context);
    return _body(context);
  }

  Widget _body(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            _text(),
            SizedBox(
              height: 20,
            ),
            _vender(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal:30.0),
              child: _checkoutBtn(context),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutBtn(context) {
    return BuyAndAddToCartButton(
      title: "Checkout",
      bgColor: Theme.of(context).primaryColorDark,
      fgColor: Theme.of(context).cardColor,
      onPressed: () {},
    );

    // MaterialButton(
    //   height: 45,
    //   minWidth: 168,
    //   elevation: 5.0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15),
    //   ),
    //   onPressed: () {},
    //   color: Theme.of(context).primaryColorDark,
    //   child: Text(
    //     "Checkout",
    //     style: GoogleFonts.raleway(
    //       color: Theme.of(context).cardColor,
    //       fontWeight: FontWeight.w600,
    //       fontSize: 17,
    //     ),
    //   ),
    // );
  }

  Widget _vender() {
    return Expanded(
      child: ListView(
        children: [
          for (int i = 0; i < 3; i++)
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _homeControllerState.onChangeWidget(2),
                  child: ProductCard(
                    favFood: "Mixed Pizza",
                    venderName: "Pepperoni Pizza",
                    addToCartFlag: true,
                    assetUrl: 'assets/foods/polopizza.png',
                    price: 650,
                    productPadding: 12,
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: 24,
                  child: Transform.scale(
                    scale: 0.8,
                    child: _productQuantity(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _productQuantity() {
    return Row(
      children: [
        EachProductBox(
          icon: _orderControllerState.prodQuantityList[0],
          onPressed: () {
            _orderControllerState.onDecrQuantity();
          },
          isSelected: !_orderControllerState.colorFlag,
        ),
        Container(
          height: 40,
          width: 38,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 4),
          child: Text(
            _orderControllerState.currentQuantity.toString(),
            style: GoogleFonts.robotoSlab(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        EachProductBox(
          icon: _orderControllerState.prodQuantityList[1],
          onPressed: () {
            _orderControllerState.onIncrQuantity();
          },
          isSelected: _orderControllerState.colorFlag,
        ),
      ],
    );
  }

  _text() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: _title(),
    );
  }

  _title() {
    return Text("My Cart", style: _themeData.headline4);
  }
}

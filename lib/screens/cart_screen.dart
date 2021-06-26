import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/controller/order_controller.dart';
import 'package:tomato_app/widgets/circular_button.dart';
import 'package:tomato_app/widgets/each_product_box.dart';
import 'package:tomato_app/widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
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
            _cartItems(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: _checkoutBtn(context),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutBtn(context) {
    return CircularButton(
      title: "Checkout",
      bgColor: Theme.of(context).primaryColorDark,
      fgColor: Theme.of(context).cardColor,
      onPressed: () {},
    );
  }

  Widget _cartItems() {
    return Expanded(
      child: ListView(
        children: [
          for (int i = 0; i < 3; i++)
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _homeControllerState.onChangeWidget(2),
                  child:Card(),
                ),
                Positioned(
                  right: 15,
                  bottom: 20,
                  child: Transform.scale(
                    scale: 0.7,
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

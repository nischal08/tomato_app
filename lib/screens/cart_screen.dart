import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';

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
        color: Theme.of(context).canvasColor,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            _text(),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _cartItems(context)),
            SizedBox(
              height: 20,
            ),
            _promoCode(context),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
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

  Widget _promoCode(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "Promo Code",
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffix: _applyBtn(context)),
      ),
    );
  }

  MaterialButton _applyBtn(context) {
    return MaterialButton(
      height: 50,
      minWidth: 100,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {},
      color: Theme.of(context).primaryColorDark,
      child: Text(
        "Apply",
        style: GoogleFonts.raleway(
          color: kColorWhiteText,
          fontWeight: FontWeight.w600,
          fontSize: 17,
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

  Widget _cartItems(context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      children: [
        for (int i = 0; i < 4; i++)
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete_forever,
                        size: 36, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: Text(
                          "Item removed",
                          style: TextStyle(color: kColorWhiteText),
                        ),
                      ),
                    );
                  },
                  key: Key("ww"),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    tileColor: Colors.green,
                    focusColor: Colors.green,
                    leading: Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: 80,
                      child: Image.network(
                        'https://siddharthabiz.com/wp-content/uploads/2020/07/quick_mom.jpg',
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: _productQuantity(),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      _homeControllerState.onChangeWidget(2);
                    },
                    // trailing: _productQuantity(),
                    title: Text(
                      "PoloPizza",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "\$60",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _productQuantity() {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: EachProductBox(
            icon: _orderControllerState.prodQuantityList[0],
            onPressed: () {
              _orderControllerState.onDecrQuantity();
            },
            isSelected: !_orderControllerState.colorFlag,
          ),
        ),
        Container(
          height: 30,
          width: 30,
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
        SizedBox(
          width: 30,
          height: 30,
          child: EachProductBox(
            icon: _orderControllerState.prodQuantityList[1],
            onPressed: () {
              _orderControllerState.onIncrQuantity();
            },
            isSelected: _orderControllerState.colorFlag,
          ),
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

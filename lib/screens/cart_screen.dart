import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/widgets/cart_item_card.dart';
import 'package:tomato_app/widgets/circular_button.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  late TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
  
    return _body(context, );
  }

  Widget _body(context, ) {
    return Container(
      color: Theme.of(context).canvasColor,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 10,
          ),
          _text(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: _cartItems(context),
          ),
          SizedBox(
            height: 15,
          ),
          _promoCode(context),
          SizedBox(
            height: 40,
          ),
          _totalAmount(context,),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: _checkoutBtn(context),
          ),
          SizedBox(
            height: 20 + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget _totalAmount(context,) {
    return 
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Rs.${Provider.of<Carts>(context).totalAmount}',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      )
    ;
  }

  Widget _promoCode(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 30, top: 16),
            hintText: "Promo Code",
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: _applyBtn(context),
          ),
        ),
      ),
    );
  }

  Widget _applyBtn(context) {
    return Container(
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5),
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).primaryColorDark,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Promo code applied"),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.0,
          ),
          child: Text(
            "Apply",
            style: GoogleFonts.raleway(
              color: kColorWhiteText,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkoutBtn(
    context,
  ) {
    return CircularButton(
      height: 65,
      title: "Checkout",
      bgColor: Theme.of(context).primaryColorDark,
      fgColor: Theme.of(context).cardColor,
      onPressed: () {},
    );
  }

  Widget _cartItems(context) {
    return Consumer<Carts>(
      builder: (context, carts, child) => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        itemCount: carts.cartItems.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider<Cart>.value(
            value: carts.cartItems[index],
            child: CartItemCard(),
          );
        },
      ),
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

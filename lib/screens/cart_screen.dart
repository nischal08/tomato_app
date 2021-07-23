import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/widgets/cart_item_card.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextTheme _themeData;

  @override
  void initState() {
    Provider.of<Carts>(context, listen: false).fetchAndSetCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: _title(context),
        elevation: 0.4,
        shadowColor: Colors.green,
        actions: [
          _totalItemCount(context),
        ],
      ),
      body: _body(
        context,
      ),
    );
  }

  Widget _body(
    context,
  ) {
    return Container(
      color: Theme.of(context).canvasColor,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _cartItems(context),
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // _promoCode(context),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 10,
            // indent: 20,
            // endIndent: 20,
            color: Colors.grey.shade300,
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          _totalAmount(
            context,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: _checkoutBtn(context),
          ),
          SizedBox(
            height: 30 + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget _totalAmount(
    context,
  ) {
    return Consumer<Carts>(
      builder: (__, value, _) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your order",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Rs.${value.totalAmount}',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoCode(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
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

  Widget _checkoutBtn(context) {
    return Container(
      height: 55,
      child: GeneralElevatedButton(
        title: "Checkout",
        bgColor: Theme.of(context).primaryColorDark,
        fgColor: Theme.of(context).cardColor,
        onPressed: () {
         

        
          Provider.of<Carts>(context, listen: false)
              .createOrders(context, );
        },
      ),
    );
  }

  Widget _cartItems(context) {
    return Consumer<Carts>(
      builder: (context, carts, child) => carts.cartItems.isEmpty
          ? _cartIsEmpty(context)
          : ListView.builder(
              // padding: EdgeInsets.symmetric(horizontal: 20.0),
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

  Container _cartIsEmpty(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-cart.png',
            height: 200,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Your cart is empty",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            """You have no items in your shopping cart.
                Let's go buy something!
                """,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  Consumer _totalItemCount(context) {
    return Consumer<Carts>(builder: (_, Carts carts, __) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            "${carts.cartItems.length} products",
            style: _themeData.subtitle2!.copyWith(
              color: kColorGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }

  _title(context) {
    return Text(
      "My Cart".toUpperCase(),
      style: _themeData.headline4!.copyWith(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

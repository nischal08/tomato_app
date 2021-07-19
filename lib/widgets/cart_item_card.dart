import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/carts.dart';
import 'package:tomato_app/models/cart.dart';

import 'each_product_box.dart';

class CartItemCard extends StatelessWidget {
  late Carts _carts;
  late Cart _cart;

  @override
  Widget build(BuildContext context) {
    _cart = Provider.of<Cart>(context, listen: false);
    _carts = Provider.of<Carts>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever,
              size: 40,
              color: Colors.white,
            ),
            padding: EdgeInsets.only(right: 20),
             margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).errorColor,
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure ?'),
                content: Text('Do you want to remove the item from cart'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
          onDismissed: (direction) {
            _carts.removeCartItem(_cart);
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
          key: ValueKey(_cart.title),
          child: _cartTile(context),
        ),
      ],
    );
  }

  Widget _cartTile(BuildContext context) {
    return Stack(
      children: [
        _cardInfo(context),
        Positioned(
          bottom: 15,
          right: 2,
          child: SizedBox(
            width: 100,
            child: _productQuantity(_cart),
          ),
        ),
        Positioned(
          top: 14,
          right: 8,
          child: _price(context),
        )
      ],
    );
  }

  Widget _cardInfo(BuildContext context) {
    return Card(
     margin: EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 70,
              minWidth: 50,
              maxHeight: 70,
              minHeight: 50,
            ),
            child: Image.asset(
              "assets/foods/burger.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        onTap: () {
          // _homeControllerState.onChangeWidget(2);
        },
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Text(
            _cart.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _cart.product.category.name,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w100, color: Colors.grey.shade600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _cart.product.restaurant.name,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w100, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _price(context) {
    return Text(
      "Rs. ${_cart.price}",
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
    );
  }

  Widget _productQuantity(_cart) {
    return Consumer<Carts>(
      builder: (context, carts, _) {
        return Row(
          children: [
            SizedBox(
              width: 35,
              height: 30,
              child: EachProductBox(
                borderRadius: 30,
                icon: Icons.remove,
                onPressed: () {
                  carts.toggleDownQuantity(_cart);
                },
                isSelected: !_cart.colorFlag,
              ),
            ),
            Container(
              height: 30,
              width: 25,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 4),
              child: Text(
                _cart.quantity.toString(),
                style: GoogleFonts.robotoSlab(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 35,
              height: 30,
              child: EachProductBox(
                borderRadius: 30,
                icon: Icons.add,
                onPressed: () {
                  carts.toggleUpQuantity(_cart);
                },
                isSelected: _cart.colorFlag,
              ),
            ),
          ],
        );
      },
    );
  }
}

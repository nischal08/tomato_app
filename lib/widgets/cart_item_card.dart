import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
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
            margin: EdgeInsets.only(bottom: 10, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
          key: ValueKey(_cart.product.id),
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
          right: 5,
          child: SizedBox(
            width: 100,
            child: _productQuantity(_cart),
          ),
        ),
        Positioned(
          top: 10,
          right: 18,
          child: _price(context),
        )
      ],
    );
  }

  Widget _cardInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 6,
          ),
          CircleAvatar(
            maxRadius: 38,
            // borderRadius: BorderRadius.circular(15),
            backgroundImage: NetworkImage(
              _cart.imageUrl == null
                  ? "https://image.flaticon.com/icons/png/512/3187/3187880.png"
                  : _cart.imageUrl!,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
              Text(
                _cart.product.category.name,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w100, color: Colors.grey.shade600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _cart.product.restaurant.name,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w100, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
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
              width: 30,
              height: 25,
              child: EachProductBox(
                borderRadius: 5,
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
              width: 30,
              height: 25,
              child: EachProductBox(
                borderRadius: 5,
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

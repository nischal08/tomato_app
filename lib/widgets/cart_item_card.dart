import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/home_controller.dart';
import 'package:tomato_app/models/cart.dart';

import 'each_product_box.dart';

class CartItemCard extends StatelessWidget {
  late HomeController _homeControllerState;
  late Cart _cart;
  late TextTheme _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context).textTheme;
    _homeControllerState = Provider.of<HomeController>(context);
    _cart = Provider.of<Cart>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever,
              size: 40,
              color: Colors.white,
            ),
            padding: EdgeInsets.only(right: 20),
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
       margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
      
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: CircleAvatar(
                  radius: 27,
                  backgroundImage: NetworkImage(
                    _cart.imageUrl,
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 100,
                child: _productQuantity(),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                // _homeControllerState.onChangeWidget(2);
              },
    
              title: Text(
                _cart.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "\$${_cart.price * _cart.quantity}",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).accentColor),
              ),
            ),
    );
  }

  Widget _productQuantity() {
    return Consumer<Cart>(
      builder: (context, cart, _) {
        return Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: EachProductBox(
                icon: Icons.remove,
                onPressed: () {
                  _cart.onDecrQuantity();
                },
                isSelected: !cart.colorFlag,
              ),
            ),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 4),
              child: Text(
                cart.quantity.toString(),
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
                icon: Icons.add,
                onPressed: () {
                  _cart.onIncrQuantity();
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

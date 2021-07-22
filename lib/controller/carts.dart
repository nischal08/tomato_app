import 'package:flutter/material.dart';
import 'package:tomato_app/database/db_helper.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/models/product_list.dart';

class Carts with ChangeNotifier {
  List<Cart> _cartItems = [];

  void addCartItem(
      {colorFlag = true, int quantity = 1, required Datum product}) {
    if (_cartItems.any((cartProd) => cartProd.productId == product.id)) {
      print("Yes it has common product on it");
      final index = _cartItems.indexWhere(
        (element) => element.productId == product.id,
      );
      print(index);
      _cartItems[index].quantity = _cartItems[index].quantity + quantity;
      _cartItems[index].totalPrice =
          _cartItems[index].totalPrice + product.price * quantity;
    } else {
      _cartItems.add(
        Cart(
          totalPrice: product.price,
          categoryName: product.category.name,
          productId: product.id,
          restaurantName: product.restaurant.name,
          imageUrl: product.image.isEmpty
              ? "https://image.flaticon.com/icons/png/512/3187/3187880.png"
              : product.image[0],
          initialPrice: product.price,
          title: product.name,
          colorFlag: colorFlag,
          quantity: quantity,
        ),
      );

    }
    notifyListeners();
  }

  void removeCartItem(Cart cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  get cartItems => this._cartItems;

  set cartItems(value) => this._cartItems = value;

  void toggleDownQuantity(Cart cart) {
    cart.onDecrQuantity();
    notifyListeners();
  }

  void toggleUpQuantity(Cart cart) {
    cart.onIncrQuantity();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((item) {
      total += item.initialPrice * item.quantity;
    });
    return total;
  }
}

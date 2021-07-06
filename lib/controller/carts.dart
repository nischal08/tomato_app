import 'package:flutter/material.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/models/product.dart';

class Carts with ChangeNotifier {
  List<Cart> _cartItems = [
    
  ];

  void addItemToCart({
    colorFlag = true,
    quantity = 1,
    required Product product,
  }) {
    _cartItems.add(Cart(
        imageUrl: product.image,
        price: product.price,
        products: product,
        title: product.title,
        colorFlag: colorFlag,
        quantity: 1));
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
      total += item.products.price * item.quantity;
    });
    return total;
  }
}

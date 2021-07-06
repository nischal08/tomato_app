import 'package:flutter/material.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/models/product.dart';

class Carts with ChangeNotifier {
  List<Cart> _cartItems = [
    Cart(
      colorFlag: true,
      quantity: 1,
      products: Product(
        image:
            "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
        name: "Burger",
        price: 230.0,
        rating: 4.4,
        type: "FastFood",
        // isFavorite: false,
      ),
      price: 230.0,
      title: "Burger",
      imageUrl:
          "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
    ),
    Cart(
      colorFlag: true,
      quantity: 1,
      products: Product(
        image:
            "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
        name: "Burger",
        price: 230.0,
        rating: 4.4,
        type: "FastFood",
        // isFavorite: false,
      ),
      price: 230.0,
      title: "Burger",
      imageUrl:
          "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
    ),
    Cart(
      colorFlag: true,
      quantity: 1,
      products: Product(
        image:
            "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
        name: "Burger",
        price: 230.0,
        rating: 4.4,
        type: "FastFood",
        // isFavorite: false,
      ),
      price: 230.0,
      title: "Burger",
      imageUrl:
          "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
    ),
    Cart(
      colorFlag: true,
      quantity: 1,
      products: Product(
        image:
            "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
        name: "Burger",
        price: 230.0,
        rating: 4.4,
        type: "FastFood",
        // isFavorite: false,
      ),
      price: 230.0,
      title: "Burger",
      imageUrl:
          "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
    )
  ];

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

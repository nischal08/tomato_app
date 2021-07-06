import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/product.dart';

class Cart with ChangeNotifier {
  int quantity;
  final Product product;
  double price;
  final String title;
  final String imageUrl;
  bool colorFlag;
  Cart(
      {this.quantity = 1,
      required this.product,
      required this.price,
      required this.title,
      required this.imageUrl,
      this.colorFlag = true});

  // int currentQuantity = 1;

  onIncrQuantity() {
    quantity++;
    price = product.price * quantity;
    colorFlag = true;
    
  }

  onDecrQuantity() {
    if (quantity > 1) {
      quantity--;
      price = product.price * quantity;
      colorFlag = false;
     
    }
  }
}

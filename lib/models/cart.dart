import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/product_list.dart' as prod;

class Cart with ChangeNotifier {
  int quantity;
  String productId;
  String restaurantName;
  int initialPrice;
  final String title;
  final String? imageUrl;
  bool colorFlag;
  String categoryName;
  int totalPrice;
  Cart({
    required this.restaurantName,
    required this.productId,
    required this.categoryName,
    this.quantity = 1,
    required this.initialPrice,
    required this.title,
    this.imageUrl,
    required this.totalPrice,
    this.colorFlag = true,
  });

  // int currentQuantity = 1;

  onIncrQuantity() {
    quantity++;
    totalPrice = (initialPrice * quantity);
    colorFlag = true;
    
  }

  onDecrQuantity() {
    if (quantity > 1) {
      quantity--;
      totalPrice = (initialPrice * quantity);
      colorFlag = false;
     
    }
  }
}

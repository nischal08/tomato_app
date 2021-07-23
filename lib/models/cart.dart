import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/database/db_helper.dart';
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
    DBHelper.update("cart", id: productId, mapData: {
      "id": productId,
      "title": title,
      "image": imageUrl!.isEmpty
          ? "https://image.flaticon.com/icons/png/512/3187/3187880.png"
          : imageUrl,
      "restaurantName": restaurantName,
      "categoryName": categoryName,
      "quantity": quantity,
      "price": initialPrice,
      "totalPrice": totalPrice,
    });
  }

  onDecrQuantity() {
    if (quantity > 1) {
      quantity--;
      totalPrice = (initialPrice * quantity);
      colorFlag = false;
      DBHelper.update("cart", id: productId, mapData: {
        "id": productId,
        "title": title,
        "image": imageUrl!.isEmpty
            ? "https://image.flaticon.com/icons/png/512/3187/3187880.png"
            : imageUrl,
        "restaurantName": restaurantName,
        "categoryName": categoryName,
        "quantity": quantity,
        "price": initialPrice,
        "totalPrice": totalPrice,
      });
    }
  }
}

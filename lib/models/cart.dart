import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/product_list.dart' as prod;

class Cart with ChangeNotifier {
  int quantity;
  final prod.Datum product;
  int price;
  final String title;
  final String? imageUrl;
  bool colorFlag;
  Cart(
      {this.quantity = 1,
      required this.product,
      required this.price,
      required this.title,
      this.imageUrl =
          "https://siddharthabiz.com/wp-content/uploads/2020/07/quick_mom.jpg",
      this.colorFlag = true});

  // int currentQuantity = 1;

  onIncrQuantity() {
    quantity++;
    price = (product.price * quantity);
    colorFlag = true;
    // notifyListeners();
  }

  onDecrQuantity() {
    if (quantity > 1) {
      quantity--;
      price = product.price * quantity;
      colorFlag = false;
      // notifyListeners();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailController extends ChangeNotifier {
  int currentProductSize = 0;
  int currentQuantity = 1;
  bool colorFlag = true;
  List productSizeList = [
    "S",
    "M",
    "L",
  ];

  List prodQuantityList = [
    Icons.remove,
    Icons.add,
  ];

  onIncrQuantity() {
    currentQuantity++;
    colorFlag = true;
    notifyListeners();
  }

  onDecrQuantity() {
    if (currentQuantity > 1) {
      currentQuantity--;
      colorFlag = false;
      notifyListeners();
    }
  }

  onProductSizeClick(int index) {
    currentProductSize = index;
    notifyListeners();
  }
}

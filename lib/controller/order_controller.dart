
import 'package:flutter/material.dart';

class OrderController extends ChangeNotifier{
int currentQuantity = 1;
  bool colorFlag = true;
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
  
}
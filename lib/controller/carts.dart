import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/database/db_helper.dart';
import 'package:tomato_app/models/cart.dart';
import 'package:tomato_app/models/order_response.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Carts with ChangeNotifier {
  List<Cart> _cartItems = [];
  bool showOrderSpinner = false;

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
      notifyListeners();
    } else {
      _cartItems.add(
        Cart(
          totalPrice: product.price * quantity,
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
      notifyListeners();
    }

    print(
      "totalPrice" + (product.price * quantity).toString(),
    );
    DBHelper.insert(
      "cart",
      {
        "id": product.id,
        "title": product.name,
        "image": product.image.isEmpty
            ? "https://image.flaticon.com/icons/png/512/3187/3187880.png"
            : product.image[0],
        "restaurantName": product.restaurant.name,
        "categoryName": product.category.name,
        "quantity": quantity,
        "price": product.price,
        "totalPrice": product.price * quantity,
      },
    );
  }

  Future<void> fetchAndSetCarts() async {
    final dataList = await DBHelper.getData("cart");
    _cartItems = dataList
        .map(
          (item) => Cart(
              categoryName: item["categoryName"],
              initialPrice: item["price"].toInt(),
              totalPrice: item["price"].toInt(),
              productId: item["id"],
              title: item["title"],
              restaurantName: item["restaurantName"],
              colorFlag: true,
              imageUrl: item["image"],
              quantity: item["quantity"].toInt()),
        )
        .toList();
    notifyListeners();
  }

  void removeCartItem(Cart cartItem) {
    _cartItems.remove(cartItem);
    DBHelper.remove("cart", cartItem.productId);
    notifyListeners();
  }

  void removeAllCartItem() {
    _cartItems.clear();
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

  Future<void> createOrders(
    context,
  ) async {
    showOrderSpinner = false;
    notifyListeners();
    late Response response;
    String url = "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/orders";
    print(url);
    List<Map<String, Object>> itemData = [
      for (Cart cartItem in cartItems)
        {"item": "${cartItem.productId}", "quantity": "${cartItem.quantity}"}
    ];
    Map jsonData = {
      "address": {
        "type": "Point",
        "coordinates": [-122.5, 37.7]
      },
      "items": itemData,
      "information": "Deliver to Baneshwor",
    };

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("accessToken");
    print(token);
    try {
      response = await ApiCall.postApi(
        jsonData: jsonData,
        url: url,
        headerValue: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (json.decode(response.body)["success"] as bool == true) {
        OrderResponse successResponse = OrderResponse.fromJson(response.body);
        removeAllCartItem();
        DBHelper.removeAll("cart");
        ScaffoldMessenger.of(context).showSnackBar(
            generalSnackBar(successResponse.data.information, context));
      } else {
        var errMessage = json.decode(response.body)["message"];
        generalAlertDialog(context, errMessage);
      }
      showOrderSpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }
}

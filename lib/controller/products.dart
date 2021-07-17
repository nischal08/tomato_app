import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Products with ChangeNotifier {


  String _categoryKey = "All";
  // ignore: unnecessary_getters_setters
  String get categoryKey => _categoryKey;

  Map<String, dynamic> _categoryList = {
    "Fast food": "assets/category/fast-food.png",
    "Pizza": "assets/category/pizza.png",
    "Bakery": "assets/category/bakery.png",
    "Drinks": "assets/category/drinks.png",
    "All": "assets/category/all.png",
  };
  // ignore: unnecessary_getters_setters
  Map get categoryList => _categoryList;

  onClickCategory({required String currentKey}) {
    _categoryKey = currentKey;
    notifyListeners();
  }
  bool showSpinner = false;
  List<Datum> items = [];
  Future<void> getItems(context, {required String restaurantId}) async {
    showSpinner = true;

    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/items?projection=name reciepe ingredients category restaurant price&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&restaurant=$restaurantId";
    print(url);

    print("From on getItem in products!!!");
    try {
      response = await ApiCall.getApi(
        url,
      );

      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
        ProductListResponse listResponse =
            ProductListResponse.fromJson(response.body);
        items = listResponse.data;

        print(items);
        ScaffoldMessenger.of(context).showSnackBar(
          generalSnackBar(listResponse.message, context),
        );
      } else {
        var errMessage = responseBody["message"];
        generalAlertDialog(context, errMessage);
      }

      showSpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> getCategory(
    context,
  ) async {
    showSpinner = true;

    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/categories?projection=name &pageNumber=0&pageSize=10&sortField=_id&sortOrder=1";
    print(url);

    print("From on getItem in products!!!");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('accessToken');
    try {
      response =
          await ApiCall.getApi(url, headerValue: {"Authorization": token!});

      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
        ProductListResponse listResponse =
            ProductListResponse.fromJson(response.body);
        items = listResponse.data;

        print(items);
        ScaffoldMessenger.of(context).showSnackBar(
          generalSnackBar(listResponse.message, context),
        );
      } else {
        var errMessage = responseBody["message"];
        generalAlertDialog(context, errMessage);
      }

      showSpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }
}

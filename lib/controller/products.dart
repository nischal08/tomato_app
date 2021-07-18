import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';
import 'package:tomato_app/models/category_model.dart ' as category;

class Products with ChangeNotifier {
  List<category.Datum> categoryItems = [];
  String currentCategory = "60e8356c0c30d50054d3dba3";

  List<Datum> restaurantMenuItems = [];

  List<Datum> itemAsPerCategory = [];

//  List<Datum> get selectedItems{
//    return items.where((element) => element.category.id==categoryKey).toList();
//  }

  Map<String, String> categoryList = {
    "Fast food": "assets/category/fast-food.png",
    "Pizza": "assets/category/pizza.png",
    "Bakery": "assets/category/bakery.png",
    "Drinks": "assets/category/drinks.png",
    "Dinner": "assets/category/dinner.png",
    "All": "assets/category/all.png",
  };

  bool toggleSearchbar = false;
  void ontoggleSearchbar() {
    toggleSearchbar = !toggleSearchbar;
    notifyListeners();
  }

  onClickCategory(context,
      {required String currentKey, bool isAll = false}) async {
    currentCategory = currentKey;

    notifyListeners();
    getItemAsPerCategory(context, isAll: isAll);
  }

  bool showSpinner = false;
  bool itemAsCategorySpinner = false;
  bool categorySpinner = false;

  Future<void> getRestaurantItems(context,
      {required String restaurantId}) async {
        restaurantMenuItems.clear();
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
        restaurantMenuItems = listResponse.data;

        print(restaurantMenuItems);
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

  Future<void> getItemAsPerCategory(context,
      {bool isAll = false, String? searchWord}) async {
    itemAsCategorySpinner = true;
    late Response response;
    String url = searchWord != null
        ? "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/items?pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&searchWord=$searchWord&projection=name reciepe ingredients category restaurant price"
        : isAll
            ? "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/items?projection=name reciepe ingredients category restaurant price&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&"
            : "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/items?projection=name reciepe ingredients category restaurant price&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&category=$currentCategory";
    print(url);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('accessToken');
    print("From on get item as Category in products!!!");
    print(token);
    print("From on get item as Category in products!!!");
    try {
      response = await ApiCall.getApi(url,
          headerValue: {HttpHeaders.authorizationHeader: "Bearer $token"});

      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
        ProductListResponse listResponse =
            ProductListResponse.fromJson(response.body);
        itemAsPerCategory = listResponse.data;

        // print(restaurantMenuItems);
     if(searchWord==null)   ScaffoldMessenger.of(context).showSnackBar(
          generalSnackBar(listResponse.message, context),
        );
      } else {
        var errMessage = responseBody["message"];
        generalAlertDialog(context, errMessage);
      }
      itemAsCategorySpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> getCategory(
    context,
  ) async {
    categorySpinner = true;
    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/categories?pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&projection=name ";
    print(url);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('accessToken');
    print("From on getCategory in products!!!");
    print(token);
    print("From on getCategory in products!!!");
    try {
      response = await ApiCall.getApi(
        url,
        headerValue: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      print("From on getCategory in products!!!");
      print("!!!response of category!!!!: ${response.body}");
      print("From on getCategory in products!!!");
      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
        category.CategoryListResponse listResponse =
            category.CategoryListResponse.fromJson(response.body);
        categoryItems = listResponse.data;
        print(categoryItems);
        categorySpinner = false;
        notifyListeners();

        // ScaffoldMessenger.of(context).showSnackBar(
        //   generalSnackBar(listResponse.message, context),
        // );
      } else {
        var errMessage = responseBody["message"];
        generalAlertDialog(context, errMessage);
      }
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }
}

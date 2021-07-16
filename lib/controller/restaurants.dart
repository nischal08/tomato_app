import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/restaurant_list_model.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Restaurants extends ChangeNotifier {
  List<Data> items = [];
  bool toggleSearchbar = false;
  bool showSpinner = false;
  void ontoggleSearchbar() {
    toggleSearchbar = !toggleSearchbar;
    notifyListeners();
  }

  String _categoryKey = "All";
  // ignore: unnecessary_getters_setters
  String get categoryKey => _categoryKey;

  String _userImageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/31f9j3A3xKasyUMMsuIQO8/6a8708add4cb4505b65b1cee3f2e6996/9db2e04eb42b427f4968ab41009443b906e4eabf-people_men-min.jpg?fit=fill&w=368&h=207";
  // ignore: unnecessary_getters_setters
  String get userImgUrl => _userImageUrl;

  Map<String, dynamic> _categoryList = {
    "All": "assets/category/all.png",
    "Fast food": "assets/category/fast-food.png",
    "Pizza": "assets/category/pizza.png",
    "Bakery": "assets/category/bakery.png",
    "Drinks": "assets/category/drinks.png",
  };
  // ignore: unnecessary_getters_setters
  Map get categoryList => _categoryList;

  onClickCategory({required String currentKey}) {
    _categoryKey = currentKey;
    notifyListeners();
  }

  Future<void> getRestaurantList(context) async {
    showSpinner = true;
    
    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/restaurants?projection=name image address&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1";
    print(url);

    print("From on getRestaurantList AuthCon!!!");
    try {
      response = await ApiCall.getApi(
        url,
      );

      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
     
        RestaurantListModel listResponse =
            RestaurantListModel.fromJson(response.body);
       
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

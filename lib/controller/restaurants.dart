import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/restaurant_info_response.dart';
import 'package:tomato_app/models/restaurant_list_model.dart' as rlr;
import 'package:tomato_app/widgets/reusable_widget.dart';

class Restaurants extends ChangeNotifier {
  List<rlr.Datum> items = [];

  RestaurantInfoResponse? restaurantInfoResponse;
  bool toggleSearchbar = false;
  bool showSpinner = false;
  void ontoggleSearchbar() {
    toggleSearchbar = !toggleSearchbar;
    notifyListeners();
  }

  String _userImageUrl =
      "https://images.ctfassets.net/hrltx12pl8hq/31f9j3A3xKasyUMMsuIQO8/6a8708add4cb4505b65b1cee3f2e6996/9db2e04eb42b427f4968ab41009443b906e4eabf-people_men-min.jpg?fit=fill&w=368&h=207";
  // ignore: unnecessary_getters_setters
  String get userImgUrl => _userImageUrl;

  Future<void> getRestaurantInfo(context, {required String id}) async {
    late Response response;
    restaurantInfoResponse = null;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/restaurants/$id";
    print(url);
    try {
      response = await ApiCall.getApi(
        url,
      );

      if (json.decode(response.body)["success"] as bool == true) {
        RestaurantInfoResponse successResponse =
            RestaurantInfoResponse.fromJson(response.body);

        restaurantInfoResponse = successResponse;
        print("From on getRestaurantInfo in products!!!");
        print(restaurantInfoResponse!.data.name);
        print("From on getRestaurantInfo in products!!!");
      } else {
        var errMessage = json.decode(response.body)["message"];
        generalAlertDialog(context, errMessage);
        restaurantInfoResponse = null;
      }

      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> getRestaurantList(context, {String? searchWord}) async {
    items.clear();
    showSpinner = true;
    late Response response;
    String url = searchWord != null
        ? "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/restaurants?projection=name image address&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&searchWord=$searchWord"
        : "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/restaurants?projection=name image address&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1";
    print(url);

    print("From on getRestaurantList AuthCon!!!");
    try {
      response = await ApiCall.getApi(
        url,
      );

      var responseBody = json.decode(response.body);
      if (responseBody["success"] == true) {
        rlr.RestaurantListModel listResponse =
            rlr.RestaurantListModel.fromJson(response.body);

        items = listResponse.data;

        print(listResponse.data);
        if (searchWord == null)
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

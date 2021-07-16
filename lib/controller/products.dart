import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Products with ChangeNotifier {
  bool showSpinner = false;
  List<Datum> items = [];
  Future<void> getItems(context, {required String restaurantId}) async {
    showSpinner = true;
    notifyListeners();
    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/items?projection=name reciepe category restaurant price&pageNumber=0&pageSize=10&sortField=_id&sortOrder=1&restaurant=$restaurantId";
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
        notifyListeners();
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

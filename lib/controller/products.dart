import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/product_list.dart ' as prod;
import 'package:tomato_app/models/product_list.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Products with ChangeNotifier {
  bool showSpinner = false;
  List<Datum> items = [
    // Product(
    //   image:
    //       "https://siddharthabiz.com/wp-content/uploads/2020/07/quick_mom.jpg",
    //   title: "Momo",
    //   price: 100.0,
    //   rating: 4.2,
    //   type: "FastFood",
    //   // isFavorite: true,
    // ),
    // Product(
    //   image:
    //       "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F19%2F2014%2F07%2F10%2Fpepperoni-pizza-ck-x.jpg&q=85",
    //   title: "Pepperoni pizza",
    //   price: 533.0,
    //   rating: 4.5,
    //   type: "Mixed Pizza",
    //   // isFavorite: false,
    // ),
    // Product(
    //   image:
    //       "https://bsansar.sgp1.digitaloceanspaces.com/2019/08/Big-B-Burger-2.jpg",
    //   title: "Burger",
    //   price: 230.0,
    //   rating: 4.4,
    //   type: "FastFood",
    //   // isFavorite: false,
    // ),
    // Product(
    //   image: "https://i.ytimg.com/vi/vZZYcW9Sz90/maxresdefault.jpg",
    //   title: "Chowmein",
    //   price: 100.0,
    //   rating: 4.7,
    //   type: "FastFood",
    //   // isFavorite: true,
    // ),
    // Product(
    //   image:
    //       "https://images-gmi-pmc.edge-generalmills.com/1fd2e37a-2c90-4e07-ad57-a3c218fe1ea9.jpg",
    //   title: "Meat balls",
    //   price: 222.0,
    //   rating: 4.6,
    //   type: "FastFood",
    //   // isFavorite: false,
    // ),
    // Product(
    //   image:
    //       "https://cookwithrenu.com/wp-content/uploads/2019/09/Thukpa_3-500x375.jpg",
    //   title: "Thukpa",
    //   price: 120.0,
    //   rating: 4.3,
    //   type: "FastFood",
    //   // isFavorite: true,
    // ),
    // Product(
    //   image:
    //       "https://media-cdn.grubhub.com/image/upload/f_auto,fl_lossy,q_80,c_fill,w_200,h_150/wbiy2owp7htth91araet",
    //   title: "Chirping Chicken",
    //   price: 420.0,
    //   rating: 4.2,
    //   type: "Continental",
    //   // isFavorite: false,
    // ),
  ];
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

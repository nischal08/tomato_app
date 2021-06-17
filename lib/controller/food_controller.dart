import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/category_type_model.dart';
import 'package:http/http.dart' as http;

class FoodController extends ChangeNotifier {
  List<CategoryTypeModel> categoryItems = [];

  String categoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php";

  Future<void> getFoodCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse(categoryUrl),
      );

      var decodedResponse = jsonDecode(response.body);
      List listResponse = decodedResponse['categories'];
      listResponse.forEach(
        (itemCategory) {
          CategoryTypeModel _tempCategoryItem = CategoryTypeModel(
              id: itemCategory["idCategory"],
              name: itemCategory["strCategory"],
              image: itemCategory["strCategoryThumb"],
              description: itemCategory["strCategoryDescription"]);

          categoryItems.add(_tempCategoryItem);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

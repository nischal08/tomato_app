import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tomato_app/models/category_type_model.dart';
import 'package:http/http.dart' as http;

class FoodController extends ChangeNotifier {
  List<CategoryTypeModel> _categoryItems = [];
  get categoryItems => this._categoryItems;

  set categoryItems(value) => this._categoryItems = value;

  String categoryUrl = "https://www.themealdb.com/api/json/v1/1/categories.php";

  Future<void> getFoodCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse(categoryUrl),
      );
      _categoryItems = [];
      final decodedResponse = jsonDecode(response.body);
      final List listResponse = decodedResponse['categories'];
      listResponse.forEach(
        (itemCategory) {
          _categoryItems.add(
            CategoryTypeModel(
              id: itemCategory["idCategory"],
              name: itemCategory["strCategory"],
              image: itemCategory["strCategoryThumb"],
              description: itemCategory["strCategoryDescription"],
            ),
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

// To parse this JSON data, do
//
//     final productListResponse = productListResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/widgets.dart';

class ProductListResponse {
  ProductListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.totalData,
  });

  bool success;
  String message;
  List<Datum> data;
  int totalData;

  factory ProductListResponse.fromJson(String str) =>
      ProductListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListResponse.fromMap(Map<String, dynamic> json) =>
      ProductListResponse(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        totalData: json["totalData"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "totalData": totalData,
      };
}

class Datum with ChangeNotifier {
  Datum({
    this.isFavorite = false,
    required this.image,
    required this.ingredients,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.restaurant,
  });
  bool isFavorite;
  List<String> image;
  List<dynamic> ingredients;
  String id;
  String name;
  int price;
  Category category;
  Restaurant restaurant;
  void toggleFavoriteStatus() {
    print("!!!!Toggle Fav Status!!!!");
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    print("!!!!Toggle Fav Status!!!!");
  }

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        image: List<String>.from(json["image"].map((x) => x)),
        ingredients: List<dynamic>.from(json["ingredients"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        category: Category.fromMap(json["category"]),
        restaurant: Restaurant.fromMap(json["restaurant"]),
      );

  Map<String, dynamic> toMap() => {
        "image": List<dynamic>.from(image.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "_id": id,
        "name": name,
        "price": price,
        "category": category.toMap(),
        "restaurant": restaurant.toMap(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
      };
}

class Restaurant {
  Restaurant({
    required this.contactNumber,
    required this.id,
    required this.name,
  });

  List<int> contactNumber;
  String id;
  String name;

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        contactNumber: List<int>.from(json["contactNumber"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "contactNumber": List<dynamic>.from(contactNumber.map((x) => x)),
        "_id": id,
        "name": name,
      };
}

// To parse this JSON data, do
//
//     final productListResponse = productListResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ProductListResponse {
  ProductListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.totalData,
  });

  final bool success;
  final String message;
  final List<Datum> data;
  final int totalData;

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

class Datum with ChangeNotifier{
  Datum({
    required this.image,
    required this.ingredients,
    required this.id,
    required this.category,
    required this.restaurant,
    required this.name,
    required this.price,
    required this.reciepe,
    this.isFavorite = false,
  });
 bool isFavorite;
  final List<String> image;
  final List<dynamic> ingredients;
  final String id;
  final Category category;
  final Restaurant restaurant;
  final String name;
  final int price;
  final String reciepe;
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
        category: Category.fromMap(json["category"]),
        restaurant: Restaurant.fromMap(json["restaurant"]),
        name: json["name"],
        price: json["price"],
        reciepe: json["reciepe"] == null ? null : json["reciepe"],
      );

  Map<String, dynamic> toMap() => {
        "image": List<dynamic>.from(image.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "_id": id,
        "category": category.toMap(),
        "restaurant": restaurant.toMap(),
        "name": name,
        "price": price,
        "reciepe": reciepe == null ? null : reciepe,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

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

  final List<int> contactNumber;
  final String id;
  final String name;

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

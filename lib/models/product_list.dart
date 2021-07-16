// To parse this JSON data, do
//
//     final productListResponse = productListResponseFromMap(jsonString);

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

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

class Datum with ChangeNotifier {
  Datum({
    required this.id,
    required this.name,
    required this.reciepe,
    required this.category,
    required this.restaurant,
    required this.price,
    this.isFavorite = false,
  });
  bool isFavorite;
  final String id;
  final String name;
  final String reciepe;
  final Category category;
  final Restaurant restaurant;
  final int price;

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
        id: json["_id"],
        name: json["name"],
        reciepe: json["reciepe"],
        category: Category.fromMap(json["category"]),
        restaurant: Restaurant.fromMap(json["restaurant"]),
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "reciepe": reciepe,
        "category": category.toMap(),
        "restaurant": restaurant.toMap(),
        "price": price,
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

  final List<dynamic> contactNumber;
  final String id;
  final String name;

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        contactNumber: List<dynamic>.from(json["contactNumber"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "contactNumber": List<dynamic>.from(contactNumber.map((x) => x)),
        "_id": id,
        "name": name,
      };
}

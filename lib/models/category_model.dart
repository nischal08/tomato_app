// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CategoryListResponse {
  CategoryListResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.totalData,
  });

  final bool success;
  final String message;
  final List<Datum> data;
  final int totalData;

  factory CategoryListResponse.fromJson(String str) =>
      CategoryListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryListResponse.fromMap(Map<String, dynamic> json) =>
      CategoryListResponse(
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

class Datum {
  Datum({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
      };
}

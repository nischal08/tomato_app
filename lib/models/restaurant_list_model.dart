

import 'dart:convert';

class RestaurantListModel {
  RestaurantListModel({
    required this.success,
    required this.message,
    required this.data,
    required this.totalData,
  });

  final bool success;
  final String message;
  final List<Datum> data;
  final int totalData;

  factory RestaurantListModel.fromJson(String str) =>
      RestaurantListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantListModel.fromMap(Map<String, dynamic> json) =>
      RestaurantListModel(
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
    required this.image,
    required this.id,
    required this.name,
    required this.address,
  });

  final List<String> image;
  final String id;
  final String name;
  final List<Address> address;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        image: List<String>.from(json["image"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "image": List<dynamic>.from(image.map((x) => x)),
        "_id": id,
        "name": name,
        "address": List<dynamic>.from(address.map((x) => x.toMap())),
      };
}

class Address {
  Address({
    required this.type,
    required this.coordinates,
    required this.id,
  });

  final String type;
  final List<double> coordinates;
  final String id;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "_id": id,
      };
}

// To parse this JSON data, do
//
//     final restaurantInfoResponse = restaurantInfoResponseFromMap(jsonString);

import 'dart:convert';

class RestaurantInfoResponse {
  RestaurantInfoResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory RestaurantInfoResponse.fromJson(String str) =>
      RestaurantInfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantInfoResponse.fromMap(Map<String, dynamic> json) =>
      RestaurantInfoResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.contactNumber,
    required this.image,
    required this.active,
    required this.id,
    required this.name,
    required this.address,
    required this.createdBy,
    required this.createdAt,
    required this.v,
  });

  final List<dynamic> contactNumber;
  final List<dynamic> image;
  final bool active;
  final String id;
  final String name;
  final List<Address> address;
  final String createdBy;
  final DateTime createdAt;
  final int v;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        contactNumber: List<dynamic>.from(json["contactNumber"].map((x) => x)),
        image: List<dynamic>.from(json["image"].map((x) => x)),
        active: json["active"],
        id: json["_id"],
        name: json["name"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "contactNumber": List<dynamic>.from(contactNumber.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x)),
        "active": active,
        "_id": id,
        "name": name,
        "address": List<dynamic>.from(address.map((x) => x.toMap())),
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
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

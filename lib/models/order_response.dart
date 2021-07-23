// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromMap(jsonString);

import 'dart:convert';

class OrderResponse {
  OrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final Data data;

  factory OrderResponse.fromJson(String str) =>
      OrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromMap(Map<String, dynamic> json) => OrderResponse(
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
    required this.active,
    required this.id,
    required this.address,
    required this.items,
    required this.information,
    required this.restaurant,
    required this.totalPrice,
    required this.createdBy,
    required this.createdAt,
    required this.v,
  });

  final bool active;
  final String id;
  final Address address;
  final List<Item> items;
  final String information;
  final String restaurant;
  final int totalPrice;
  final String createdBy;
  final DateTime createdAt;
  final int v;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        active: json["active"],
        id: json["_id"],
        address: Address.fromMap(json["address"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        information: json["information"],
        restaurant: json["restaurant"],
        totalPrice: json["totalPrice"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "active": active,
        "_id": id,
        "address": address.toMap(),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "information": information,
        "restaurant": restaurant,
        "totalPrice": totalPrice,
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

class Item {
  Item({
    required this.id,
    required this.item,
    required this.quantity,
  });

  final String id;
  final String item;
  final int quantity;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["_id"],
        item: json["item"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "item": item,
        "quantity": quantity,
      };
}

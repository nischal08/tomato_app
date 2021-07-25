// To parse this JSON data, do
//
//     final orderRequest = orderRequestFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderRequest orderRequestFromMap(String str) =>
    OrderRequest.fromMap(json.decode(str));

String orderRequestToMap(OrderRequest data) => json.encode(data.toMap());

class OrderRequest {
  OrderRequest({
    required this.items,
    required this.information,
    required this.address,
  });

  final List<Item> items;
  final String information;
  final Address address;

  factory OrderRequest.fromMap(Map<String, dynamic> json) => OrderRequest(
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        information: json["information"],
        address: Address.fromMap(json["address"]),
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "information": information,
        "address": address.toMap(),
      };
}

class Address {
  Address({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Item {
  Item({
    required this.item,
    required this.quantity,
  });

  final String item;
  final String quantity;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        item: json["item"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "item": item,
        "quantity": quantity,
      };
}

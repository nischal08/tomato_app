import 'dart:convert';

import 'package:flutter/foundation.dart';

class RestaurantListModel {
  final bool success;
  final String message;
  final List<Data> data;
  final int totalData;
  RestaurantListModel({
    required this.success,
    required this.message,
    required this.data,
    required this.totalData,
  });

  RestaurantListModel copyWith({
    bool? success,
    String? message,
    List<Data>? data,
    int? totalData,
  }) {
    return RestaurantListModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      totalData: totalData ?? this.totalData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
      'totalData': totalData,
    };
  }

  factory RestaurantListModel.fromMap(Map<String, dynamic> map) {
    return RestaurantListModel(
      success: map['success'],
      message: map['message'],
      data: List<Data>.from(map['data']?.map((x) => Data.fromMap(x))),
      totalData: map['totalData']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantListModel.fromJson(String source) =>
      RestaurantListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RestaurantListModel(success: $success, message: $message, data: $data, totalData: $totalData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RestaurantListModel &&
        other.success == success &&
        other.message == message &&
        listEquals(other.data, data) &&
        other.totalData == totalData;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        data.hashCode ^
        totalData.hashCode;
  }
}

class Data {
  final List<dynamic> image;
  final String id;
  final String name;
  final List<Addres> address;
  Data({
    required this.image,
    required this.id,
    required this.name,
    required this.address,
  });

  Data copyWith({
    List<dynamic>? image,
    String? id,
    String? name,
    List<Addres>? address,
  }) {
    return Data(
      image: image ?? this.image,
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      '_id': id,
      'name': name,
      'address': address.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      image: List<dynamic>.from(map['image']),
      id: map['_id'],
      name: map['name'],
      address: List<Addres>.from(map['address']?.map((x) => Addres.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(image: $image, _id: $id, name: $name, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        listEquals(other.image, image) &&
        other.id == id &&
        other.name == name &&
        listEquals(other.address, address);
  }

  @override
  int get hashCode {
    return image.hashCode ^ id.hashCode ^ name.hashCode ^ address.hashCode;
  }
}

class Addres {
  final String type;
  final List<double> coordinates;
  final String id;
  Addres({
    required this.type,
    required this.coordinates,
    required this.id,
  });

  Addres copyWith({
    String? type,
    List<double>? coordinates,
    String? id,
  }) {
    return Addres(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'coordinates': coordinates,
      '_id': id,
    };
  }

  factory Addres.fromMap(Map<String, dynamic> map) {
    return Addres(
      type: map['type'],
      coordinates: List<double>.from(map['coordinates']),
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Addres.fromJson(String source) => Addres.fromMap(json.decode(source));

  @override
  String toString() =>
      'Addres(type: $type, coordinates: $coordinates, _id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Addres &&
        other.type == type &&
        listEquals(other.coordinates, coordinates) &&
        other.id == id;
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode ^ id.hashCode;
}

// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromMap(jsonString);

import 'dart:convert';

class OrdersModel {
  OrdersModel({
  required  this.success,
  required  this.message,
  required  this.data,
  required  this.totalData,
  });

  bool success;
  String message;
  List<Datum> data;
  int totalData;

  factory OrdersModel.fromJson(String str) =>
      OrdersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdersModel.fromMap(Map<String, dynamic> json) => OrdersModel(
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
   required this.status,
   required this.active,
   required this.id,
   required this.address,
   required this.items,
   required this.information,
   required this.totalPrice,
   required this.createdBy,
   required this.createdAt,
   required this.v,
   required this.restaurant,
  });

  Status status;
  bool active;
  String id;
  Address address;
  List<ItemElement> items;
  Information information;
  int totalPrice;
  CreatedBy createdBy;
  DateTime createdAt;
  int v;
  String restaurant;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        status: statusValues.map[json["status"]]!,
        active: json["active"],
        id: json["_id"],
        address: Address.fromMap(json["address"]),
        items: List<ItemElement>.from(
            json["items"].map((x) => ItemElement.fromMap(x))),
        information: informationValues.map[json["information"]]!,
        totalPrice: json["totalPrice"],
        createdBy: createdByValues.map[json["createdBy"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        restaurant: json["restaurant"] == null ? null : json["restaurant"],
      );

  Map<String, dynamic> toMap() => {
        "status": statusValues.reverse[status],
        "active": active,
        "_id": id,
        "address": address.toMap(),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "information": informationValues.reverse[information],
        "totalPrice": totalPrice,
        "createdBy": createdByValues.reverse[createdBy],
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "restaurant": restaurant == null ? null : restaurant,
      };
}

class Address {
  Address({
  required  this.type,
  required  this.coordinates,
  required  this.id,
  });

  Type type;
  List<double> coordinates;
  String id;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        type: typeValues.map[json["type"]]!,
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "type": typeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "_id": id,
      };
}

enum Type { POINT }

final typeValues = EnumValues({"Point": Type.POINT});

enum CreatedBy { THE_60_F4271_DC2_BDAD00047_E4_A98 }

final createdByValues = EnumValues(
    {"60f4271dc2bdad00047e4a98": CreatedBy.THE_60_F4271_DC2_BDAD00047_E4_A98});

enum Information { DELIVER_TO_BANESHWOR, DELIVER_TO_INSTANCE_OF_FUTURE_STRING }

final informationValues = EnumValues({
  "Deliver to Baneshwor": Information.DELIVER_TO_BANESHWOR,
  "Deliver to Instance of 'Future<String>'":
      Information.DELIVER_TO_INSTANCE_OF_FUTURE_STRING
});

class ItemElement {
  ItemElement({
   required this.id,
   required this.item,
   required this.quantity,
  });

  String id;
  ItemItem item;
  int quantity;

  factory ItemElement.fromJson(String str) =>
      ItemElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemElement.fromMap(Map<String, dynamic> json) => ItemElement(
        id: json["_id"],
        item: ItemItem.fromMap(json["item"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "item": item.toMap(),
        "quantity": quantity,
      };
}

class ItemItem {
  ItemItem({
    required this.id,
    required this.name,
    required this.price,
  });

  Id id;
  Name name;
  int price;

  factory ItemItem.fromJson(String str) => ItemItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemItem.fromMap(Map<String, dynamic> json) => ItemItem(
        id: idValues.map[json["_id"]]!,
        name: nameValues.map[json["name"]]!,
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "_id": idValues.reverse[id],
        "name": nameValues.reverse[name],
        "price": price,
      };
}

enum Id {
  THE_60_E835_D5_C4_ACC70004_EEC24_F,
  THE_60_F949_DBA23_A070004_EB8_B60,
  THE_60_F173_BAB37_D3_E00047_FBF2_A,
  THE_60_F2_DBE444_ED90000440310_B
}

final idValues = EnumValues({
  "60e835d5c4acc70004eec24f": Id.THE_60_E835_D5_C4_ACC70004_EEC24_F,
  "60f173bab37d3e00047fbf2a": Id.THE_60_F173_BAB37_D3_E00047_FBF2_A,
  "60f2dbe444ed90000440310b": Id.THE_60_F2_DBE444_ED90000440310_B,
  "60f949dba23a070004eb8b60": Id.THE_60_F949_DBA23_A070004_EB8_B60
});

enum Name { BUFF_MOMO, CHOWMEIN, SPECIAL_CHOWMEIN, LAPHING }

final nameValues = EnumValues({
  "Buff Momo": Name.BUFF_MOMO,
  "Chowmein": Name.CHOWMEIN,
  "Laphing": Name.LAPHING,
  "Special Chowmein": Name.SPECIAL_CHOWMEIN
});

enum Status { REQUESTED }

final statusValues = EnumValues({"requested": Status.REQUESTED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

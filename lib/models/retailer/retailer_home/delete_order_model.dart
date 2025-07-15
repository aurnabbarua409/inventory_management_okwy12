// To parse this JSON data, do
//
//     final mDeleteOrder = mDeleteOrderFromJson(jsonString);

import 'dart:convert';

MDeleteOrder mDeleteOrderFromJson(String str) => MDeleteOrder.fromJson(json.decode(str));

String mDeleteOrderToJson(MDeleteOrder data) => json.encode(data.toJson());

class MDeleteOrder {
    bool success;
    String message;
    Data data;

    MDeleteOrder({
        required this.success,
        required this.message,
        required this.data,
    });

    factory MDeleteOrder.fromJson(Map<String, dynamic> json) => MDeleteOrder(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String name;
    String unit;
    int quantity;
    String additionalInfo;
    int v;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.name,
        required this.unit,
        required this.quantity,
        required this.additionalInfo,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        unit: json["unit"] ?? '',
        quantity: json["quantity"] ?? '',
        additionalInfo: json["additionalInfo"] ?? '',
        v: json["__v"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? ''),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "unit": unit,
        "quantity": quantity,
        "additionalInfo": additionalInfo,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

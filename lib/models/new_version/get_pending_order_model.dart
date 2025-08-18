import 'package:flutter/material.dart';

class GetPendingOrderModel {
  final String? id;
  final List<Product>? product;
  final String? status;
  final Retailer? retailer;
  final Wholesaler? wholesaler;
  final String? createAt;
  final String? updatedAt;

  GetPendingOrderModel({
    this.id,
    this.product,
    this.status,
    this.retailer,
    this.wholesaler,
    this.createAt,
    this.updatedAt,
  });
  factory GetPendingOrderModel.fromJson(Map<String, dynamic> json) =>
      GetPendingOrderModel(
        id: json['_id'] ?? "N/A",
        product:
            List<Product>.from(json['product'].map((x) => Product.fromJson(x))),
        status: json['status'] ?? "pending",
        retailer: Retailer.fromJson(json['retailer'] ?? {}),
        wholesaler: Wholesaler.fromJson(json['wholesaler'] ?? {}),
        createAt: json['createdAt'].toString(),
        updatedAt: json['updatedAt'].toString(),
      );
}

class Product {
  final String? id;
  String? productName;
  String? unit;
  int? quantity;
  String? additionalInfo;
  final String? retailer;
  final bool? status;
  final String? createAt;
  final String? updatedAt;
  final int? v;
  bool? availability;
  int? price;
  TextEditingController? textEditingController;

  Product(
      {required this.id,
      required this.productName,
      required this.unit,
      required this.quantity,
      required this.additionalInfo,
      required this.retailer,
      required this.status,
      required this.createAt,
      required this.updatedAt,
      this.availability = false,
      this.price = 0,
      this.textEditingController,
      required this.v});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] ?? "N/A",
      productName: json['productName'] ?? "N/A",
      unit: json['unit'] ?? "Pcs",
      quantity: json['quantity'] ?? 0,
      additionalInfo: json['additionalInfo'] ?? "N/A",
      retailer: json['retailer'] ?? "",
      status: json['status'] ?? false,
      createAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
      availability: json['availability'] ?? false,
      price: json['price'] ?? 0,
      v: json['__v'] ?? 0,
      textEditingController: TextEditingController());
}

class Retailer {
  final StoreInformation? storeInformation;
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  String? phone;
  Retailer(
      {required this.id,
      required this.name,
      required this.email,
      required this.storeInformation,
      required this.image,
      this.phone = ""});

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
      storeInformation:
          StoreInformation.fromJson(json['storeInformation'] ?? {}),
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "N/A",
      image: json['image'] ?? "",
      phone: json['phone'] ?? "");
}

class Wholesaler {
  final StoreInformation? storeInformation;
  final String? id;
  final String? name;
  final String? email;
  final String? image;
  String? phone;
  Wholesaler(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.storeInformation,
      this.phone = ""});

  factory Wholesaler.fromJson(Map<String, dynamic> json) => Wholesaler(
      storeInformation:
          StoreInformation.fromJson(json['storeInformation'] ?? {}),
      id: json['_id'] ?? "",
      name: json['name'] ?? "N/A",
      email: json['email'] ?? "N/A",
      image: json['image'] ?? "",
      phone: json['phone'] ?? "");
}

class StoreInformation {
  final String? businessname;
  String? location;
  StoreInformation({required this.businessname, this.location = ""});

  factory StoreInformation.fromJson(Map<String, dynamic> json) =>
      StoreInformation(
          businessname: json['businessName'] ?? "",
          location: json['location'] ?? "");
}

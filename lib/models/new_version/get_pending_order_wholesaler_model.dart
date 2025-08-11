import 'package:inventory_app/models/new_version/get_pending_order_model.dart';

class GetPendingOrderWholesalerModel {
  String? id;
  List<Product>? product;
  String? status;
  String? retailer;
  String? wholesaler;
  String? createAt;
  String? updateAt;
  int? v;

  GetPendingOrderWholesalerModel(
      {required this.id,
      required this.product,
      required this.status,
      required this.retailer,
      required this.wholesaler,
      required this.createAt,
      required this.updateAt,
      required this.v});

  factory GetPendingOrderWholesalerModel.fromJson(Map<String, dynamic> json) =>
      GetPendingOrderWholesalerModel(
          id: json['_id'] ?? "",
          product: List<Product>.from(
              (json['product'].map((e) => Product.fromJson(e)))),
          status: json['status'] ?? "",
          retailer: json['retailer'] ?? "N/A",
          wholesaler: json['wholesaler'] ?? "N/A",
          createAt: json['createdAt'].toString(),
          updateAt: json['updatedAt'].toString(),
          v: json['__v'] ?? 0);
}

class Retailer{
  
}
class GetPendingOrderModel {
  final String? id;
  final List<Product>? product;
  final String? status;
  final Retailer? retailer;
  final List<Wholesaler>? wholesaler;
  final String? createAt;
  final String? updatedAt;

  GetPendingOrderModel(this.id, this.product, this.status, this.retailer,
      this.wholesaler, this.createAt, this.updatedAt);
  factory GetPendingOrderModel.fromJson(Map<String, dynamic> json) =>
      GetPendingOrderModel(
          json['_id'] ?? "N/A",
          List<Product>.from(json['product'].map((x) => Product.fromJson(x))),
          json['status'] ?? "pending",
          Retailer.fromJson(json['retailer'] ?? {}),
          List<Wholesaler>.from(
              json['wholesaler'].map((x) => Wholesaler.fromJson(x))),
          json['createdAt'].toString(),
          json['updatedAt'].toString());
}

class Product {
  final String? id;
  final String? productName;
  final String? unit;
  final int? quantity;
  final String? additionalInfo;

  Product(
      this.id, this.productName, this.unit, this.quantity, this.additionalInfo);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      json['_id'] ?? "N/A",
      json['productName'] ?? "N/A",
      json['unit'] ?? "Pcs",
      json['quantity'] ?? 0,
      json['additionalInfo'] ?? "N/A");
}

class Retailer {
  final String? id;
  final String? name;
  final String? email;
  Retailer(this.id, this.name, this.email);

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
      json['_id'] ?? "N/A", json['name'] ?? "N/A", json['email'] ?? "N/A");
}

class Wholesaler {
  final String? id;
  final String? name;
  final String? email;
  Wholesaler(this.id, this.name, this.email);

  factory Wholesaler.fromJson(Map<String, dynamic> json) => Wholesaler(
      json['_id'] ?? "N/A", json['name'] ?? "N/A", json['email'] ?? "N/A");
}

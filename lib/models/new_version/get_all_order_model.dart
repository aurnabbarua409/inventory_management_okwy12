class GetAllOrderModel {
  final String? id;
  final String? productName;
  final String? unit;
  final int? quantity;
  final String? additionalInfo;
  final String? retailer;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;
  GetAllOrderModel(
      {this.id,
      this.productName,
      this.unit,
      this.quantity,
      this.additionalInfo,
      this.retailer,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory GetAllOrderModel.fromJson(Map<String, dynamic> json) =>
      GetAllOrderModel(
          id: json['_id'] ?? "N/A",
          productName: json['productName'] ?? "N/A",
          unit: json['unit'] ?? "Pcs",
          quantity: json['quantity'] ?? 0,
          additionalInfo: json['additionalInfo'] ?? "N/A",
          retailer: json['retailer'] ?? "N/A",
          status: json['status'] ?? false,
          createdAt: json['createdAt'] ?? "N/A",
          updatedAt: json['updatedAt'] ?? "N/A");
}

class GetConfirmModel {
  List<Product>? product;
  List<Retailer>? retailer;
  List<Wholesaler>? wholesaler;

  GetConfirmModel({
    this.product,
    this.retailer,
    this.wholesaler,
  });

  factory GetConfirmModel.fromJson(Map<String, dynamic> json) =>
      GetConfirmModel(
        product: List<Product>.from(
            json['products'].map((e) => Product.fromJson(e))),
        retailer: List<Retailer>.from(
            json['retailers'].map((e) => Retailer.fromJson(e))),
        wholesaler: List<Wholesaler>.from(
            json['wholesalers'].map((e) => Wholesaler.fromJson(e))),
      );
}

class Product {
  String id;
  String productName;
  String unit;
  int quantity;
  String additionalInfo;
  bool status;
  int price;
  String createAt;
  String updateAt;

  Product(
      {required this.id,
      required this.productName,
      required this.unit,
      required this.quantity,
      required this.additionalInfo,
      required this.price,
      required this.status,
      required this.createAt,
      required this.updateAt});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] ?? "N/A",
      productName: json['productName'] ?? "N/A",
      unit: json['unit'] ?? "Pcs",
      quantity: json['quantity'] ?? 0,
      additionalInfo: json['additionalInfo'] ?? "N/A",
      status: json['status'] ?? false,
      price: json['price'] ?? 0,
      createAt: json['createdAt'].toString(),
      updateAt: json['createdAt'].toString());
}

class Retailer {
  String id;
  String name;
  String phone;
  String location;

  Retailer(
      {required this.id,
      required this.name,
      required this.phone,
      required this.location});

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
      id: json['_id'] ?? "N/A",
      name: json['name'] ?? "N/A",
      phone: json['phone'] ?? "N/A",
      location: json['location'] ?? "N/A");
}

class Wholesaler {
  String id;
  String name;
  String phone;
  String location;

  Wholesaler(
      {required this.name,
      required this.id,
      required this.phone,
      required this.location});
  factory Wholesaler.fromJson(Map<String, dynamic> json) => Wholesaler(
      id: json['_id'] ?? "N/A",
      name: json['name'] ?? "N/A",
      phone: json['phone'] ?? "N/A",
      location: json['location'] ?? "N/A");
}

class GetReceivedOrderModel {
  WholeSaler? wholeSaler;
  List<Orders>? orders;

  GetReceivedOrderModel({this.wholeSaler, this.orders});

  factory GetReceivedOrderModel.fromJson(Map<String, dynamic> json) =>
      GetReceivedOrderModel(
          wholeSaler: json['wholesaler'] is Map<String, dynamic>
              ? WholeSaler.fromJson(json['wholesaler'] as Map<String, dynamic>)
              : null,
          orders:
              List<Orders>.from(json['orders'].map((e) => Orders.fromJson(e))));
}

class WholeSaler {
  String? id;
  String? name;
  String? email;
  String? image;
  String? createAt;
  String? updateAt;
  WholeSaler(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.createAt,
      this.updateAt});

  factory WholeSaler.fromJson(Map<String, dynamic> json) => WholeSaler(
      id: json['_id'] ?? "N/A",
      name: json['name'] ?? "N/A",
      email: json['email'] ?? "N/A",
      image: json['image'] ?? "N/A",
      createAt: json['createdAt'] ?? "N/A",
      updateAt: json['updatedAt'] ?? "N/A");
}

class Orders {
  String? id;
  Product? product;
  String? status;
  int? price;
  bool? availability;
  String? createAt;

  Orders(
      {this.id,
      this.product,
      this.status,
      this.price,
      this.availability,
      this.createAt});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
      id: json['_id'] as String,
      product: Product.fromJson(json['product'] ?? {}),
      status: json['status'] as String,
      price: json['price']?? 1.0,
      availability: json['availability'] as bool,
      createAt: json['createdAt'] as String);
}

class Product {
  String? id;
  String? productName;
  String? unit;
  int? quantity;
  String? createAt;
  String? updateAt;

  Product(
      {this.id,
      this.productName,
      this.unit,
      this.quantity,
      this.createAt,
      this.updateAt});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] ?? "N/A",
      productName: json['productName'] ?? "N/A",
      unit: json['unit'] ?? "N/A",
      quantity: json['quantity'] ?? 0,
      createAt: json['createdAt'] ?? "N/A",
      updateAt: json['updatedAt'] ?? "N/A");
}

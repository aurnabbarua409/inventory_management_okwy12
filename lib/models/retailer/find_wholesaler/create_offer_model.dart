class MCreateOffer {
  bool success;
  int total;
  String message;
  List<Order> data;

  MCreateOffer({
    required this.success,
    required this.total,
    required this.message,
    required this.data,
  });

  factory MCreateOffer.fromJson(Map<String, dynamic> json) {
    return MCreateOffer(
      success: json['success'],
      total: json['Total'],
      message: json['message'],
      data: List<Order>.from(json['data'].map((order) => Order.fromJson(order))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'Total': total,
      'message': message,
      'data': data.map((order) => order.toJson()).toList(),
    };
  }
}

class Order {
  String retailer;
  List<Product> product;
  String wholeSeller;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Order({
    required this.retailer,
    required this.product,
    required this.wholeSeller,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      retailer: json['retailer'],
      product: List<Product>.from(json['product'].map((product) => Product.fromJson(product))),
      wholeSeller: json['wholeSeller'],
      status: json['status'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'retailer': retailer,
      'product': product.map((product) => product.toJson()).toList(),
      'wholeSeller': wholeSeller,
      'status': status,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class Product {
  String productId;
  bool availability;
  double price;
  String id;

  Product({
    required this.productId,
    required this.availability,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      availability: json['availability'],
      price: json['price'].toDouble(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'availability': availability,
      'price': price,
      '_id': id,
    };
  }
}

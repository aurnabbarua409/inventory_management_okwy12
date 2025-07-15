class ProductResponse {
  bool success;
  int total;
  String message;
  List<Product> data;

  ProductResponse({
    required this.success,
    required this.total,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      total: json['Total'],
      message: json['message'],
      data: List<Product>.from(
          json['data'].map((product) => Product.fromJson(product))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'Total': total,
      'message': message,
      'data': data.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  String ? id;
  String name;
  String unit;
  int quantity;
  String? additionalInfo;
  bool? delivery;
  bool? availability;
  int? v;
  DateTime ? createdAt;
  DateTime ? updatedAt;
  int? price;

  Product({
     this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    this.additionalInfo,
    this.delivery,
    this.availability,
    this.v,
     this.createdAt,
     this.updatedAt,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      unit: json['unit'],
      quantity: json['quantity'],
      additionalInfo: json['additionalInfo'],
      delivery: json['Delivery'],
      availability: json['availability'],
      v: json['__v'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'additionalInfo': additionalInfo,
      'Delivery': delivery,
      'availability': availability,
      '__v': v,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'price': price,
    };
  }
}

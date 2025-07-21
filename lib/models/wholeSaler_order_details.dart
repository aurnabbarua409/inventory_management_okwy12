class Order {
  final String id;
  final Retailer retailer;
  final List<Product> product;
  final WholeSeller wholeSeller;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Order({
    required this.id,
    required this.retailer,
    required this.product,
    required this.wholeSeller,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? " ",
      retailer: Retailer.fromJson(json['retailer'] ?? {}),
      product: json['product'] != null
          ? List<Product>.from(
              json['product'].map((x) => Product.fromJson(x)),
            )
          : [],
      wholeSeller: WholeSeller.fromJson(json['wholeSeller'] ?? {}),
      status: json['status'] ?? " ",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'retailer': retailer.toJson(),
        'product': product.map((x) => x.toJson()).toList(),
        'wholeSeller': wholeSeller.toJson(),
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };
}

class Retailer {
  final String id;
  final String name;
  final String email;
  final String phone;

  Retailer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    return Retailer(
      id: json['_id'] ?? " ",
      name: json['name'] ?? " ",
      email: json['email'] ?? " ",
      phone: json['phone'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };
}

class Product {
  final String productId;
  final bool availability;
  final int price;
  final String id;

  Product({
    required this.productId,
    required this.availability,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? " ",
      availability: json['availability'] ?? false,
      price: json['price'] ?? 0,
      id: json['_id'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'availability': availability,
        'price': price,
        '_id': id,
      };
}

class WholeSeller {
  final String id;
  final String name;
  final String email;
  final String phone;

  WholeSeller({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory WholeSeller.fromJson(Map<String, dynamic> json) {
    return WholeSeller(
      id: json['_id'] ?? " ",
      name: json['name'] ?? " ",
      email: json['email'] ?? " ",
      phone: json['phone'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };
}

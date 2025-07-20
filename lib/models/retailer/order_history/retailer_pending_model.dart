class MPendingOrders {
  bool? success;
  int? total;
  List<Datum> data;

  MPendingOrders({
    this.success,
    this.total,
    required this.data,
  });

  factory MPendingOrders.fromJson(dynamic json) => MPendingOrders(
        success: json["success"] ?? false,
        total: json["Total"] ?? 0,
        data:
            List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)) ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  Retailer retailer;
  List<Product> product;
  Retailer wholeSeller;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.retailer,
    required this.product,
    required this.wholeSeller,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] ?? "",
        retailer: Retailer.fromJson(json["retailer"] ?? {}),
        product: json["product"] != null && json["product"] is List
            ? List<Product>.from(
                json["product"].map((x) => Product.fromJson(x)))
            : [],
        wholeSeller: Retailer.fromJson(json["wholeSeller"] ?? {}),
        status: json["status"] ?? "",
        createdAt: DateTime.parse(json["createdAt"] ?? ""),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "retailer": retailer.toJson(),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "wholeSeller": wholeSeller.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Retailer {
  String id;
  String name;
  String email;
  StoreInformation storeInformation;

  Retailer({
    required this.id,
    required this.name,
    required this.email,
    required this.storeInformation,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        storeInformation:
            StoreInformation.fromJson(json["storeInformation"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "storeInformation": storeInformation.toJson(),
      };
}

class Wholesaler {
  String id;
  String name;
  String email;
  StoreInformation storeInformation;

  Wholesaler({
    required this.id,
    required this.name,
    required this.email,
    required this.storeInformation,
  });

  factory Wholesaler.fromJson(Map<String, dynamic> json) => Wholesaler(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        storeInformation:
            StoreInformation.fromJson(json["storeInformation"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "storeInformation": storeInformation.toJson(),
      };
}

class StoreInformation {
  String businessName;
  String businessCategory;
  String location;
  bool? verified;

  StoreInformation({
    required this.businessName,
    required this.businessCategory,
    required this.location,
    this.verified,
  });

  factory StoreInformation.fromJson(Map<String, dynamic> json) =>
      StoreInformation(
        businessName: json["businessName"] ?? "",
        businessCategory: json["businessCategory"] ?? "",
        location: json["location"] ?? "",
        verified: json["verified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "businessCategory": businessCategory,
        "location": location,
        "verified": verified ?? false,
      };
}

class Product {
  ProductId productId;
  bool availability;
  double price;
  String id;
  double total; // Add the total field to calculate dynamically

  Product({
    required this.productId,
    required this.availability,
    required this.price,
    required this.id,
    this.total = 0.0, // Initialize total to 0
  });

  // Method to calculate the total price for a product
  void calculateTotal() {
    total = price * productId.quantity; // Total = price * quantity
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: ProductId.fromJson(json["productId"] ?? {}),
        availability: json["availability"] ?? false,
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "availability": availability,
        "price": price,
        "_id": id,
        "total":
            total, // Optionally, include total if required to return in JSON
      };
}

class ProductId {
  String id;
  String name;
  String unit;
  int quantity; // This property represents the quantity of the product
  String additionalInfo;

  ProductId({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.additionalInfo,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        unit: json["unit"] ?? "",
        quantity: (json["quantity"] as num?)?.toInt() ?? 0,
        additionalInfo: json["additionalInfo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "unit": unit,
        "quantity": quantity,
        "additionalInfo": additionalInfo,
      };
}

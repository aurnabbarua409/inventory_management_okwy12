class MConfirmedOrders {
  bool? success;
  int? total;
  List<Confirmed> data;

  MConfirmedOrders({
    this.success,
    this.total,
    required this.data,
  });

  factory MConfirmedOrders.fromJson(dynamic json) => MConfirmedOrders(
        success: json["success"],
        total: json["Total"],
        data: List<Confirmed>.from(
            json["data"].map((x) => Confirmed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Confirmed {
  String? id;
  Retailer? retailer;
  List<ProductConfirmed> product;
  WholeSeller? wholeSeller;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Confirmed({
    this.id,
    this.retailer,
    required this.product,
    this.wholeSeller,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
        id: json["_id"] ?? "",
        retailer: json["retailer"] != null && json["retailer"] is Map
            ? Retailer.fromJson(json["retailer"])
            : Retailer(
                id: "",
                name: "",
                email: "",
                storeInformation: StoreInformation(
                    businessName: "", businessCategory: "", location: "")),
        product: json["product"] != null && json["product"] is List
            ? List<ProductConfirmed>.from(
                json["product"].map((x) => ProductConfirmed.fromJson(x)))
            : [],
        wholeSeller: json["wholeSeller"] != null && json["wholeSeller"] is Map
            ? WholeSeller.fromJson(json["wholeSeller"])
            : WholeSeller(
                id: "",
                name: "",
                email: "",
                storeInformation: StoreInformation(
                    businessName: "", businessCategory: "", location: "")),
        status: json["status"] ?? "",
        createdAt: DateTime.parse(json["createdAt"] ?? ""),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "retailer": retailer?.toJson(),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "wholeSeller": wholeSeller?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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

class WholeSeller {
  String id;
  String name;
  String email;
  StoreInformation storeInformation;

  WholeSeller({
    required this.id,
    required this.name,
    required this.email,
    required this.storeInformation,
  });

  factory WholeSeller.fromJson(Map<String, dynamic> json) => WholeSeller(
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

class ProductConfirmed {
  ConfirmedProductId productId;
  bool availability;
  double price;
  String id;

  ProductConfirmed({
    required this.productId,
    required this.availability,
    required this.price,
    required this.id,
  });

  factory ProductConfirmed.fromJson(Map<String, dynamic> json) =>
      ProductConfirmed(
        productId: ConfirmedProductId.fromJson(json["productId"] ?? {}),
        availability: json["availability"] ?? false,
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "availability": availability,
        "price": price,
        "_id": id,
      };
}

class ConfirmedProductId {
  String id;
  String name;
  String unit;
  int quantity;
  String additionalInfo;

  ConfirmedProductId({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.additionalInfo,
  });

  factory ConfirmedProductId.fromJson(Map<String, dynamic> json) =>
      ConfirmedProductId(
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

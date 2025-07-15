class MReceivedOrders {
  bool? success;
  int? total;
  List<Received> data;

  MReceivedOrders({
    this.success,
    this.total,
    required this.data,
  });

  factory MReceivedOrders.fromJson(dynamic json) => MReceivedOrders(
        success: json["success"],
        total: json["Total"],
        data:
            List<Received>.from(json["data"].map((x) => Received.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Received {
  String id;
  Retailer retailer;
  List<ProductReceived> product;
  WholeSeller wholeSeller;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Received({
    required this.id,
    required this.retailer,
    required this.product,
    required this.wholeSeller,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Received.fromJson(Map<String, dynamic> json) => Received(
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
            ? List<ProductReceived>.from(
                json["product"].map((x) => ProductReceived.fromJson(x)))
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

class ProductReceived {
  ReceivedProductId productId;
  bool availability;
  double price;
  String id;

  ProductReceived({
    required this.productId,
    required this.availability,
    required this.price,
    required this.id,
  });

  factory ProductReceived.fromJson(Map<String, dynamic> json) =>
      ProductReceived(
        productId: ReceivedProductId.fromJson(json["productId"] ?? {}),
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

class ReceivedProductId {
  String id;
  String name;
  String unit;
  int quantity;
  String additionalInfo;

  ReceivedProductId({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.additionalInfo,
  });

  factory ReceivedProductId.fromJson(Map<String, dynamic> json) =>
      ReceivedProductId(
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

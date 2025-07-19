// To parse this JSON data, do
//
//     final mGetWholesalers = mGetWholesalersFromJson(jsonString);

class MGetWholesalers {
  bool success;
  int total;
  String message;
  List<WholeSalerDetails> data;

  MGetWholesalers({
    required this.success,
    required this.total,
    required this.message,
    required this.data,
  });

  factory MGetWholesalers.fromJson(Map<String, dynamic> json) =>
      MGetWholesalers(
        success: json["success"],
        total: json["Total"],
        message: json["message"],
        data: List<WholeSalerDetails>.from(
            json["data"].map((x) => WholeSalerDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Total": total,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WholeSalerDetails {
  StoreInformation storeInformation;
  Authentication authentication;
  String id;
  String name;
  String email;
  String phone;
  String confirmPassword;
  String image;
  String status;
  bool isSubscribed;
  bool verified;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  WholeSalerDetails({
    required this.storeInformation,
    required this.authentication,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.confirmPassword,
    required this.image,
    required this.status,
    required this.isSubscribed,
    required this.verified,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WholeSalerDetails.fromJson(Map<String, dynamic> json) =>
      WholeSalerDetails(
        storeInformation: json["storeInformation"] != null
            ? StoreInformation.fromJson(json["storeInformation"])
            : StoreInformation(
                businessName: "",
                businessCategory: "",
                location: "",
                verified: false,
              ),
        authentication: Authentication.fromJson(json["authentication"]),
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        confirmPassword: json["confirmPassword"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? "",
        isSubscribed: json["isSubscribed"] ?? false,
        verified: json["verified"] ?? false,
        role: json["role"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "storeInformation": storeInformation.toJson(),
        "authentication": authentication.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "confirmPassword": confirmPassword,
        "image": image,
        "status": status,
        "isSubscribed": isSubscribed,
        "verified": verified,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class StoreInformation {
  String businessName;
  String businessCategory;
  String location;
  bool verified;

  StoreInformation({
    required this.businessName,
    required this.businessCategory,
    required this.location,
    required this.verified,
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
        "verified": verified,
      };
}

class Authentication {
  bool isResetPassword;
  dynamic oneTimeCode;
  dynamic expireAt;

  Authentication({
    required this.isResetPassword,
    this.oneTimeCode,
    this.expireAt,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        isResetPassword: json["isResetPassword"] ?? false,
        oneTimeCode: json["oneTimeCode"],
        expireAt: json["expireAt"],
      );

  Map<String, dynamic> toJson() => {
        "isResetPassword": isResetPassword,
        "oneTimeCode": oneTimeCode,
        "expireAt": expireAt,
      };
}


class StoreUpdateResponse {
  bool success;
  String message;
  StoreUpdateData data;

  StoreUpdateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StoreUpdateResponse.fromJson(Map<String, dynamic> json) => StoreUpdateResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: StoreUpdateData.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class StoreUpdateData {
  StoreInformation storeInformation;
  Authentication authentication;
  String id;
  String  name;
  String  email;
  String confirmPassword;
  String image;
  String status;
  bool isSubscribed;
  bool verified;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  StoreUpdateData({
    required this.storeInformation,
    required this.authentication,
    required this.id,
    required this.name,
    required this.email,
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

  factory StoreUpdateData.fromJson(Map<String, dynamic> json) => StoreUpdateData(
    storeInformation: StoreInformation.fromJson(json["storeInformation"] ?? {}),
    authentication: Authentication.fromJson(json["authentication"] ?? {}),
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    confirmPassword: json["confirmPassword"] ?? "",
    image: json["image"] ?? "",
    status: json["status"] ?? "",
    isSubscribed: json["isSubscribed"] ?? false,
    verified: json["verified"] ?? false,
    role: json["role"] ?? "",
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "confirmPassword": confirmPassword,
    "image": image,
    "status": status,
    "isSubscribed": isSubscribed,
    "verified": verified,
    "role": role,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "storeInformation": storeInformation.toJson(),
    "authentication": authentication.toJson(),
  };
}

class StoreInformation {
  bool verified;
  String businessName;
  String businessCategory;
  String location;

  StoreInformation({
    required this.verified,
    required this.businessName,
    required this.businessCategory,
    required this.location,
  });

  factory StoreInformation.fromJson(Map<String, dynamic> json) => StoreInformation(
    verified: json["verified"] ?? false,
    businessName: json["businessName"] ?? "",
    businessCategory: json["businessCategory"] ?? "",
    location: json["location"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "verified": verified,
    "businessName": businessName,
    "businessCategory": businessCategory,
    "location": location,
  };
}

class Authentication {
  bool isResetPassword;
  int oneTimeCode;
  DateTime expireAt;

  Authentication({
    required this.isResetPassword,
    required this.oneTimeCode,
    required this.expireAt,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    isResetPassword: json["isResetPassword"] ?? false,
    oneTimeCode: json["oneTimeCode"] ?? 0,
    expireAt: DateTime.parse(json["expireAt"] ?? DateTime.now().toString()),
  );

  Map<String, dynamic> toJson() => {
    "isResetPassword": isResetPassword,
    "oneTimeCode": oneTimeCode,
    "expireAt": expireAt.toIso8601String(),
  };
}

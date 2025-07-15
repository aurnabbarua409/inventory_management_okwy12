class ProfileResponse {
  bool success;
  String message;
  ProfileData data;

  ProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: ProfileData.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class ProfileData {
  StoreInformation storeInformation;
  Authentication authentication;
  String id;
  String name;
  String email;
  String confirmPassword;
  String businessName;
  String role;
  String businessCategory;
  String location;
  String image;
  String status;
  bool verified;
  bool isSubscribed;
  String createdAt;
  String updatedAt;
  int v;
  String phone;

  ProfileData({
    required this.storeInformation,
    required this.authentication,
    required this.id,
    required this.name,
    required this.email,
    required this.confirmPassword,
    required this.businessName,
    required this.role,
    required this.businessCategory,
    required this.location,
    required this.image,
    required this.status,
    required this.verified,
    required this.isSubscribed,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.phone,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      storeInformation:
          StoreInformation.fromJson(json["storeInformation"] ?? {}),
      authentication: Authentication.fromJson(json["authentication"] ?? {}),
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      confirmPassword: json["confirmPassword"] ?? "",
      businessName: json["businessName"] ?? "",
      role: json["role"] ?? "",
      businessCategory: json["businessCategory"] ?? "",
      location: json["location"] ?? "",
      image: json["image"] ?? "",
      status: json["status"] ?? "",
      verified: json["verified"] ?? false,
      isSubscribed: json["isSubscribed"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      v: json["__v"] ?? 0,
      phone: json["phone"] ?? "", // Null-safe for phone
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "storeInformation": storeInformation.toJson(),
      "authentication": authentication.toJson(),
      "_id": id,
      "name": name,
      "email": email,
      "confirmPassword": confirmPassword,
      "businessName": businessName,
      "role": role,
      "businessCategory": businessCategory,
      "location": location,
      "image": image,
      "status": status,
      "verified": verified,
      "isSubscribed": isSubscribed,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
      "phone": phone,
    };
  }
}

class StoreInformation {
  bool verified;

  StoreInformation({
    required this.verified,
  });

  factory StoreInformation.fromJson(Map<String, dynamic> json) {
    return StoreInformation(
      verified: json["verified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "verified": verified,
    };
  }
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

  factory Authentication.fromJson(Map<String, dynamic> json) {
    return Authentication(
      isResetPassword: json["isResetPassword"] ?? false,
      oneTimeCode:
          json["oneTimeCode"], // No default needed if the API can return null
      expireAt: json["expireAt"], // Handle null with default
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isResetPassword": isResetPassword,
      "oneTimeCode": oneTimeCode,
      "expireAt": expireAt,
    };
  }
}

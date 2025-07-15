
class UserCreationResponse {
  bool success;
  String message;
  UserData data;

  UserCreationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserCreationResponse.fromJson(Map<String, dynamic> json) =>
      UserCreationResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: UserData.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  String name;
  String email;
  String password;
  String confirmPassword;
  String image;
  String status;
  bool isSubscribed;
  bool verified;
  String role;
  StoreInformation storeInformation;
  Authentication authentication;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserData({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.image,
    required this.status,
    required this.isSubscribed,
    required this.verified,
    required this.role,
    required this.storeInformation,
    required this.authentication,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        confirmPassword: json["confirmPassword"] ?? "",
        image: json["image"] ?? "",
        status: json["status"] ?? "",
        isSubscribed: json["isSubscribed"] ?? false,
        verified: json["verified"] ?? false,
        role: json["role"] ?? "",
        storeInformation: StoreInformation.fromJson(json["storeInformation"] ?? {}),
        authentication: Authentication.fromJson(json["authentication"] ?? {}),
        id: json["_id"] ?? "",
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "image": image,
        "status": status,
        "isSubscribed": isSubscribed,
        "verified": verified,
        "role": role,
        "storeInformation": storeInformation.toJson(),
        "authentication": authentication.toJson(),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class StoreInformation {
  bool verified;

  StoreInformation({
    required this.verified,
  });

  factory StoreInformation.fromJson(Map<String, dynamic> json) => StoreInformation(
        verified: json["verified"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
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


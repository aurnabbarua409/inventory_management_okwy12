import 'dart:convert';

MSignIn mSignInFromJson(String str) => MSignIn.fromJson(json.decode(str));

String mSignInToJson(MSignIn data) => json.encode(data.toJson());

class    MSignIn {
  bool success;
  String message;
  Data data;

  MSignIn({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MSignIn.fromJson(Map<String, dynamic> json) => MSignIn(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String token;
  final String role;
  final String userId;  // New field added

  Data({
    required this.token,
    required this.role,
    required this.userId,  // Include userId in the constructor
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        role: json["role"],
        userId: json["userId"],  // Extract userId
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
        "userId": userId,  // Include userId in the JSON map
      };
}

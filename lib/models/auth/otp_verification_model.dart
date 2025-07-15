import 'dart:convert';

class OTPVerificationModel {
  bool success;
  String message;
  bool data;

  OTPVerificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OTPVerificationModel.fromJson(Map<String, dynamic> json) =>
      OTPVerificationModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };

  static OTPVerificationModel fromJsonString(String str) {
    return OTPVerificationModel.fromJson(jsonDecode(str));
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

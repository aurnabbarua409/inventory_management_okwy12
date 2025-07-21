import 'dart:convert';

class OTPVerificationModel {
  bool success;
  String message;
  OtpData data;

  OTPVerificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OTPVerificationModel.fromJson(Map<String, dynamic> json) =>
      OTPVerificationModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: OtpData.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  static OTPVerificationModel fromJsonString(String str) {
    return OTPVerificationModel.fromJson(jsonDecode(str));
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class OtpData {
  final String data;
  final String message;
  OtpData({required this.data, required this.message});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(data: json["data"] ?? "", message: json["message"] ?? "");
  }
  Map<String, dynamic> toJson() => {"data": data, "message": message};
}

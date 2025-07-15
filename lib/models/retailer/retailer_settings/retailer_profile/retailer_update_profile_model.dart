// To parse this JSON data, do
//
//     final mUpdateProfile = mUpdateProfileFromJson(jsonString);

import 'dart:convert';

MUpdateProfile mUpdateProfileFromJson(String str) => MUpdateProfile.fromJson(json.decode(str));

String mUpdateProfileToJson(MUpdateProfile data) => json.encode(data.toJson());

class MUpdateProfile {
    bool success;
    String message;
    Data data;

    MUpdateProfile({
        required this.success,
        required this.message,
        required this.data,
    });

    factory MUpdateProfile.fromJson(Map<String, dynamic> json) => MUpdateProfile(
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
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String phone;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeInformation: StoreInformation.fromJson(json["storeInformation"]),
        authentication: Authentication.fromJson(json["authentication"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        confirmPassword: json["confirmPassword"],
        businessName: json["businessName"],
        role: json["role"],
        businessCategory: json["businessCategory"],
        location: json["location"],
        image: json["image"],
        status: json["status"],
        verified: json["verified"],
        isSubscribed: json["isSubscribed"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "phone": phone,
    };
}

class Authentication {
    bool isResetPassword;
    dynamic oneTimeCode;
    dynamic expireAt;

    Authentication({
        required this.isResetPassword,
        required this.oneTimeCode,
        required this.expireAt,
    });

    factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        isResetPassword: json["isResetPassword"],
        oneTimeCode: json["oneTimeCode"],
        expireAt: json["expireAt"],
    );

    Map<String, dynamic> toJson() => {
        "isResetPassword": isResetPassword,
        "oneTimeCode": oneTimeCode,
        "expireAt": expireAt,
    };
}

class StoreInformation {
    bool verified;

    StoreInformation({
        required this.verified,
    });

    factory StoreInformation.fromJson(Map<String, dynamic> json) => StoreInformation(
        verified: json["verified"],
    );

    Map<String, dynamic> toJson() => {
        "verified": verified,
    };
}

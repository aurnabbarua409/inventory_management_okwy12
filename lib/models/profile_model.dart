class ProfileModel {
  final bool success;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json['success']  ?? false,
        message: json['message']  ?? '',
        data: ProfileData.fromJson(json['data'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}

class ProfileData {
  final StoreInformation storeInformation;
  final Authentication authentication;
  final String id;
  final String name;
  final String email;
  final String confirmPassword;
  final String phone;
  final String image;
  final String status;
  final bool isSubscribed;
  final bool verified;
  final String role;
  final int offersUpdatedCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ProfileData({
    required this.storeInformation,
    required this.authentication,
    required this.id,
    required this.name,
    required this.email,
    required this.confirmPassword,
    required this.phone,
    required this.image,
    required this.status,
    required this.isSubscribed,
    required this.verified,
    required this.role,
    required this.offersUpdatedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        storeInformation: StoreInformation.fromJson(json['storeInformation']),
        authentication: Authentication.fromJson(json['authentication']),
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        confirmPassword: json['confirmPassword'] ?? '',
        phone: json['phone'] ?? '',
        image: json['image'] ?? '',
        status: json['status'] ?? '',
        isSubscribed: json['isSubscribed'] ?? false,
        verified: json['verified'] ?? false,
        role: json['role'] ?? '',
        offersUpdatedCount: json['offersUpdatedCount'] ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        v: json['__v'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'storeInformation': storeInformation.toJson(),
        'authentication': authentication.toJson(),
        '_id': id,
        'name': name,
        'email': email,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'image': image,
        'status': status,
        'isSubscribed': isSubscribed,
        'verified': verified,
        'role': role,
        'offersUpdatedCount': offersUpdatedCount,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };
}

class StoreInformation {
  final String businessName;
  final String location;

  StoreInformation({
    required this.businessName,
    required this.location,
  });

  factory StoreInformation.fromJson(Map<String, dynamic> json) => StoreInformation(
        businessName: json['businessName'] ?? '',
        location: json['location'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'businessName': businessName,
        'location': location,
      };
}

class Authentication {
  final bool isResetPassword;
  final String? oneTimeCode;
  final String? expireAt;

  Authentication({
    required this.isResetPassword,
    this.oneTimeCode,
    this.expireAt,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        isResetPassword: json['isResetPassword'] ?? false,
        oneTimeCode: json['oneTimeCode'],
        expireAt: json['expireAt'],
      );

  Map<String, dynamic> toJson() => {
        'isResetPassword': isResetPassword,
        'oneTimeCode': oneTimeCode,
        'expireAt': expireAt,
      };
}

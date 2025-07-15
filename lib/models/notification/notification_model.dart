// Notification Model class
class NotificationModel {
  String id;
  String userId;
  String title;
  String message;
  bool isRead;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create Notification object from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String? ?? '',  // Null check for _id
      userId: json['userId'] as String? ?? '',  // Null check for userId
      title: json['title'] as String? ?? '',  // Null check for title
      message: json['message'] as String? ?? '',  // Null check for message
      isRead: json['isRead'] as bool? ?? false,  // Null check for isRead
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()  // Safe DateTime parsing
          : DateTime.now(),  // Null check for createdAt
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()  // Safe DateTime parsing
          : DateTime.now(),  // Null check for updatedAt
    );
  }

  // Convert Notification object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// Response Model class for notifications
class NotificationResponse {
  final bool success;
  final int total;
  final String message;
  final List<NotificationModel> data;

  NotificationResponse({
    required this.success,
    required this.total,
    required this.message,
    required this.data,
  });

  // Factory constructor to create NotificationResponse from JSON
  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] as bool? ?? false,  // Null check for success
      total: json['Total'] is int ? json['Total'] : 0,  // Safely handling Total value
      message: json['message'] as String? ?? '',  // Null check for message
      data: (json['data'] as List?)
              ?.map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList() ?? [],
    );
  }

  // Convert NotificationResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'Total': total,
      'message': message,
      'data': data.map((notification) => notification.toJson()).toList(),
    };
  }
}

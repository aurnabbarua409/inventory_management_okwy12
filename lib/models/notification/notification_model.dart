// Notification Model class
class NotificationModel {
  String id;
  String sender;
  String receiver;
  String message;
  bool isRead;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NotificationModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.v
  });

  // Factory constructor to create Notification object from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String? ?? '', // Null check for _id
      sender: json['sender'] as String? ?? '', // Null check for userId
      receiver: json['receiver'] as String? ?? '', // Null check for title
      message: json['message'] as String? ?? '', // Null check for message
      isRead: json['isRead'] as bool? ?? false, // Null check for isRead
      createdAt: json['createdAt'] != null ? DateTime.parse( json['createdAt'].toString()) : DateTime.now()
           , // Null check for createdAt
      updatedAt: json['updatedAt'] != null? DateTime.parse(json['updatedAt'].toString()): DateTime.now(),
      v: json['__v'] ?? 0 // Null check for updatedAt
    );
  }

  // Convert Notification object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
      success: json['success'] as bool? ?? false, // Null check for success
      total: json['Total'] is int
          ? json['Total']
          : 0, // Safely handling Total value
      message: json['message'] as String? ?? '', // Null check for message
      data: (json['data'] as List?)
              ?.map((item) =>
                  NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
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

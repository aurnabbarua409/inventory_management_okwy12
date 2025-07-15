class NotificationReadResponse {
  bool success;
  String message;
  Notification data;

  NotificationReadResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory method to create a NotificationReadResponse from JSON
  factory NotificationReadResponse.fromJson(Map<String, dynamic> json) {
    return NotificationReadResponse(
      success: json['success'],
      message: json['message'],
      data: Notification.fromJson(json['data']),
    );
  }

  // Method to convert NotificationReadResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Notification {
  String id;
  String userId;
  String title;
  String message;
  bool isRead;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // Factory method to create a Notification from JSON
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'],
      userId: json['userId'],
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  // Method to convert Notification object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'message': message,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

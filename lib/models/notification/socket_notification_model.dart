/*
"sender": "689c566ddfb1312441d039ae",
    "receiver": "689c10aff418c4f67965fd5e",
    "message": "Wholesaler has confirmed the order id 689c5b71dfb1312441d03e39",
    "isRead": false,
    "_id": "689c5cf1dfb1312441d04199",
    "createdAt": "2025-08-13T09:37:53.964Z",
    "updatedAt": "2025-08-13T09:37:53.964Z",
    "__v": 0
    */

class SocketNotificationModel {
  String sender, receiver, message, id, createAt, updateAt;
  bool isRead;
  int v;

  SocketNotificationModel(
      {required this.sender,
      required this.receiver,
      required this.message,
      required this.id,
      required this.createAt,
      required this.updateAt,
      required this.isRead,
      required this.v});

  factory SocketNotificationModel.fromJson(Map<String, dynamic> json) =>
      SocketNotificationModel(
          sender: json['sender'] ?? "",
          receiver: json['receiver'] ?? "",
          message: json['message'] ?? "",
          id: json['_id'] ?? "",
          createAt: json['createdAt'] ?? "",
          updateAt: json['updatedAt'] ?? "",
          isRead: json['isRead'] ?? false,
          v: json['__v'] ?? 0);
}

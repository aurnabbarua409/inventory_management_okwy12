// class ProductResponse {
//   bool success;
//   String message;
//   ProductData data;

//   ProductResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
//         success: json["success"] ?? false,
//         message: json["message"] ?? '',
//         data: ProductData.fromJson(json["data"] ?? {}),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class ProductData {
//   String id;
//   String name;
//   String unit;
//   int quantity;
//   bool delivery;
//   bool availability;
//   int price;
//   int v;
//   DateTime createdAt;
//   DateTime updatedAt;

//   ProductData({
//     required this.id,
//     required this.name,
//     required this.unit,
//     required this.quantity,
//     required this.delivery,
//     required this.availability,
//     required this.price,
//     required this.v,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//         id: json["_id"] ?? '',
//         name: json["name"] ?? '',
//         unit: json["unit"] ?? '',
//         quantity: json["quantity"] ?? 0,
//         delivery: json["Delivery"] ?? false,
//         availability: json["availability"] ?? false,
//         price: json["price"] ?? 0,
//         v: json["__v"] ?? 0,
//         createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
//         updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "unit": unit,
//         "quantity": quantity,
//         "Delivery": delivery,
//         "availability": availability,
//         "price": price,
//         "__v": v,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }

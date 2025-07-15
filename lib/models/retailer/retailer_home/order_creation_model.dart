class MCreateOffer {
  bool success;
  String message;
  CreateProduct data; // Change from List<CreateProduct> to CreateProduct

  MCreateOffer({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MCreateOffer.fromJson(Map<String, dynamic> json) {
    return MCreateOffer(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? CreateProduct.fromJson(json['data'])
          : CreateProduct(
              // Provide a fallback in case 'data' is null
              name: '',
              unit: '',
              quantity: 0,
              additionalInfo: '',
              delivery: false,
              availability: false,
              id: '',
              v: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CreateProduct {
  String name;
  String unit;
  int quantity;
  String additionalInfo;
  bool delivery;
  bool availability;
  String id;
  int v;
  DateTime createdAt;
  DateTime updatedAt;

  CreateProduct({
    required this.name,
    required this.unit,
    required this.quantity,
    required this.additionalInfo,
    required this.delivery,
    required this.availability,
    required this.id,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateProduct.fromJson(Map<String, dynamic> json) {
    return CreateProduct(
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      quantity: json['quantity'] ?? 0, // Ensure this defaults to 0 if null
      additionalInfo: json['additionalInfo'] ?? '',
      delivery: json['Delivery'] ?? false, // Correct the key if necessary
      availability: json['availability'] ?? false,
      id: json['_id'] ?? '',
      v: json['__v'] ?? 0, // Default to 0 if version is missing
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unit': unit,
      'quantity': quantity,
      'additionalInfo': additionalInfo,
      'Delivery': delivery,
      'availability': availability,
      '_id': id,
      '__v': v,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

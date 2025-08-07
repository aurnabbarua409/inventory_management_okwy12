class CreateOrderModel {
  final String productName;
  final int quantity;
  final String unit;
  final String additionalInfo;

  CreateOrderModel(
      {required this.productName,
      required this.quantity,
      required this.additionalInfo,
      required this.unit});

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "quantity": quantity,
        "unit": unit,
        "additionalInfo": additionalInfo
      };
}

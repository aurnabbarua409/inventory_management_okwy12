class PaymentVerificationResponse {
  bool success;
  String message;
  PaymentVerificationData data;

  PaymentVerificationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory method to create a PaymentVerificationResponse from JSON
  factory PaymentVerificationResponse.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationResponse(
      success: json['success'],
      message: json['message'],
      data: PaymentVerificationData.fromJson(json['data']),
    );
  }

  // Method to convert PaymentVerificationResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class PaymentVerificationData {
  String message;
  String status;
  int transactionId;
  String txRef;
  int amount;
  String currency;
  String email;
  DateTime verifiedAt;

  PaymentVerificationData({
    required this.message,
    required this.status,
    required this.transactionId,
    required this.txRef,
    required this.amount,
    required this.currency,
    required this.email,
    required this.verifiedAt,
  });

  // Factory method to create a PaymentVerificationData from JSON
  factory PaymentVerificationData.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationData(
      message: json['message'],
      status: json['status'],
      transactionId: json['transactionId'],
      txRef: json['tx_ref'],
      amount: json['amount'],
      currency: json['currency'],
      email: json['email'],
      verifiedAt: DateTime.parse(json['verifiedAt']),
    );
  }

  // Method to convert PaymentVerificationData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'transactionId': transactionId,
      'tx_ref': txRef,
      'amount': amount,
      'currency': currency,
      'email': email,
      'verifiedAt': verifiedAt.toIso8601String(),
    };
  }
}

class PaymentResponse {
  bool success;
  String message;
  PaymentData data;

  PaymentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory method to create a PaymentResponse from JSON
  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'],
      message: json['message'],
      data: PaymentData.fromJson(json['data']),
    );
  }

  // Method to convert PaymentResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class PaymentData {
  String link;
  String txRef;
  int amount;
  String email;
  String redirectUrl;
  String status;
  String subscriptionId;

  PaymentData({
    required this.link,
    required this.txRef,
    required this.amount,
    required this.email,
    required this.redirectUrl,
    required this.status,
    required this.subscriptionId,
  });

  // Factory method to create a PaymentData from JSON
  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      link: json['link'],
      txRef: json['tx_ref'],
      amount: json['amount'],
      email: json['email'],
      redirectUrl: json['redirect_url'],
      status: json['status'],
      subscriptionId: json['subscriptionId'],
    );
  }

  // Method to convert PaymentData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'tx_ref': txRef,
      'amount': amount,
      'email': email,
      'redirect_url': redirectUrl,
      'status': status,
      'subscriptionId': subscriptionId,
    };
  }
}

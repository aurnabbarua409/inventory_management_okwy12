class Urls {
  static const baseUrl = "http://75.119.138.163:5006/api/v1";

  //"http://10.0.70.188:5006/api/v1";

  //static const imageUrl = "http://10.0.70.188:5000/api/v1";

  static const socketUrl = "http://75.119.138.163:5006";

  //"http://10.0.70.188:5006/";

  static const signUp = "$baseUrl/user";
  static const verifyingOTP = "$baseUrl/user/verify-otp";
  static const signIn = "$baseUrl/auth/login";
  static const createOrders = "$baseUrl/product/create";
  static const getAllOrders = "$baseUrl/product/";
  static const deleteOrder = "$baseUrl/product/delete";
  static const getWholesaler = "$baseUrl/wholesalers"; //?search=Rakib
  static const sendOrder = "$baseUrl/send-offer/create/";
  static const userProfile = "$baseUrl/user/profile";
  static const pendingOrder = "$baseUrl/send-offer/pending-retailer";
  static const receivedOrders = "$baseUrl/send-offer/received";
  static const confirmedOrders = "$baseUrl/send-offer/confirm";
  static const deletePending = "$baseUrl/send-offer/pending/";
  static const storeInfo = "$baseUrl/user/update-store/";
  static const getNotification = "$baseUrl/notification/";
  static const readNotification = "$baseUrl/notification/";
  static const flutterWavePackagePay = "$baseUrl/flutter-wave-package/pay";
  static const forgetPassword = "$baseUrl/auth/forget-password";
  static const changePassword = "$baseUrl/auth/change-password";
}

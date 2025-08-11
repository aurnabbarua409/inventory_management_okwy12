class Urls {
  // static const baseUrl = "http://75.119.138.163:5006/api/v1";
  static const baseUrl = "http://10.10.7.46:5006/api/v1";
  //"http://10.0.70.188:5006/api/v1";

  //static const imageUrl = "http://10.0.70.188:5000/api/v1";
  static const socketUrl = "http://10.10.7.46:5006";
  // static const socketUrl = "http://75.119.138.163:5006";

  //"http://10.0.70.188:5006/";

  static const signUp = "$baseUrl/user";
  static const verifyingOTP = "$baseUrl/user/verify-otp";
  static const signIn = "$baseUrl/auth/login";
  static const createOrders = "$baseUrl/new-order/create";
  static const getAllOrders = "$baseUrl/new-order/all";
  static const deleteOrder = "$baseUrl/product/delete";
  static const getWholesaler = "$baseUrl/wholesalers"; //?search=Rakib
  static const sendOrder = "$baseUrl/products/send";
  static const userProfile = "$baseUrl/user/profile";
  static const newPendingOrder = "$baseUrl/products/all/pending";
  static const receivedOrdersRetailer = "$baseUrl/products/all/received";
  static const receivedOrders = "$baseUrl/send-offer/received";
  static const confirmedOrders = "$baseUrl/confirmation/";
  static const deletePending = "$baseUrl/send-offer/pending/";
  static const storeInfo = "$baseUrl/user/update-store/";
  static const getNotification = "$baseUrl/notification/";
  static const readNotification = "$baseUrl/notification/";
  static const flutterWavePackagePay = "$baseUrl/flutter-wave-package/pay";
  static const forgetPassword = "$baseUrl/auth/forget-password";
  static const changePassword = "$baseUrl/auth/change-password";
  static const resetPassword = "$baseUrl/auth/reset-password";
  static const wholesalerProductDetailsFromRetailer =
      "$baseUrl/send-offer/pending/";
  static const updateProduct = "$baseUrl/products/update/";
  static const updateWholesalerProduct = "$baseUrl/send-offer/update-product/";
  static const updateReceivedOrder = "$baseUrl/new-order/";
  static const updateAllReceivedOrders = "$baseUrl/confirmation";
  static const confirmedOrderRetailer = "$baseUrl/products/all/confirm";
  static const confirmedOrderWholesaler = "$baseUrl/products/all-product/confirm";

  // retailer received order
  static const receivedOrderRetailer = "$baseUrl/products/all/received";
  static const pendingOrderWholesaler =
      "$baseUrl/products/all-product/received";
}

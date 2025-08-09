import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            _handlePageFinished(url); // Call your handler function
          },
        ),
      );
  }

  Future<void> createPaymentPackage() async {
    try {
      String userEmail = PrefsHelper.emailId;
      debugPrint('==============Fetched user email=========: $userEmail');

      double staticAmount = 5000.0;

      if (userEmail.isNotEmpty && staticAmount > 0) {
        debugPrint("============================user email: $userEmail");
        debugPrint("============================amount: $staticAmount");

        Map<String, dynamic> body = {
          'amount': staticAmount,
          'userEmail': userEmail,
        };

        var response =
            await ApiService.postApi(Urls.flutterWavePackagePay, body);

        if (response != null && response['success'] == true) {
          String paymentUrl = response['data']['link'];
          launchWebView(paymentUrl);
        } else {
          debugPrint('Failed to create payment package. Response: $response');
          if (response != null && response['message'] != null) {
            Get.snackbar('Payment Error', response['message']);
          } else {
            Get.snackbar('Payment Error', 'Payment initiation failed!');
          }
        }
      } else {
        debugPrint('Please enter valid email and amount');
        Get.snackbar('Input Error', 'Please enter a valid email and amount');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
      Get.snackbar(
          'Payment Error', 'An error occurred while initiating payment');
    }
  }

  void launchWebView(String paymentUrl) {
    webViewController.loadRequest(Uri.parse(paymentUrl));
    debugPrint('Payment URL: $paymentUrl');
  }

  void _handlePageFinished(String url) {
    if (url.contains('payment-success')) {
      debugPrint('Payment successful!');
      String? transactionId = _extractTransactionId(url);
      if (transactionId != null) {
        verifyTransaction(transactionId);
      } else {
        debugPrint("No transaction ID found in the URL.");
      }
    } else if (url.contains('payment-failure')) {
      debugPrint('Payment failed!');
    } else {
      debugPrint('Unexpected URL: $url');
    }
  }

  String? _extractTransactionId(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters['transaction_id'];
  }

  Future<void> verifyTransaction(String transactionId) async {
    String userEmail = PrefsHelper.emailId;

    try {
      String verificationUrl =
          '${Urls.baseUrl}/flutter-wave-package/verify?userEmail=$userEmail&transaction_id=$transactionId'; //{{URL}}
      Map<String, String> customHeaders = {
        //'Content-Type': 'application/json',
      };

      var response =
          await ApiService.getApi(verificationUrl, header: customHeaders);

      if (response != null && response['success'] == true) {
        debugPrint('Transaction verified successfully: ${response['message']}');

        Get.snackbar('Verification', 'Transaction verified successfully',
            snackPosition: SnackPosition.TOP);
      } else {
        debugPrint('Transaction verification failed: ${response?['message']}');

        Get.snackbar('Verification', 'Transaction verification failed',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      debugPrint('Error verifying transaction: $e');

      Get.snackbar('Verification', 'Error verifying transaction',
          snackPosition: SnackPosition.TOP);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_strings.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/controller/subs_controller.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/controller/subscription_controller.dart';
import 'package:inventory_app/widgets/appbar_widget/appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import webview_flutter

class PaymentWebViewPage extends StatefulWidget {
  const PaymentWebViewPage({super.key, required this.controller});
  final PaymentController controller;
  @override
  State<PaymentWebViewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        text: AppStrings.payMent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.find<SubscriptionController>().initial();
            Get.back();
          },
        ),
      ),
      body: WebViewWidget(controller: widget.controller.webViewController),
    );
  }
}

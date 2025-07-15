import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/models/retailer/retailer_home/get_orders_model.dart';
import 'package:inventory_app/models/retailer/retailer_home/order_creation_model.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_saved_order_screen/controller/retailer_saved_order_screen_controller.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_saved_order_screen/retailer_saved_order_screen.dart';
import 'package:inventory_app/services/api_service.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../../constants/app_colors.dart';

class RetailerCreateNewOrderScreenController extends GetxController {
  static RetailerSavedOrderScreenController controller =
      Get.put(RetailerSavedOrderScreenController());

  // TextEditingControllers for the fields
  final productNameController = TextEditingController();
  final additionalInfoController = TextEditingController();

  // Observable quantity for increment and decrement
  var quantity = 1.obs;
  var isLoading = false.obs;
  var selectedUnit = 'Pcs'.obs;
  final List<String> units = [
    'Pcs',
    'Cup',
    'Unit',
    'Roll',
    'Crate',
    'Bottle',
    'Carton',
    'Gal',
    'Bag',
    'Pkt',
    'Other',
  ];

  //SpeechToText speechToText = SpeechToText();
  var isListening = false.obs;
  var lastWords = ''.obs;

  /// Increment the quantity
  void incrementQuantity() {
    quantity.value++;
  }

  /// Decrement the quantity (minimum is 1)
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    } else {
      Get.snackbar(
        'Warning',
        'Quantity cannot be less than 1',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.yellow,
        colorText: AppColors.blackDarkest,
      );
    }
  }

  void setSelectedUnit(String? value) {
    selectedUnit.value = value ?? '';
  }

  Future<void> startVoiceRecognition() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      stt.SpeechToText speechToText = stt.SpeechToText();
      String currentLocaleId = 'en_US';
      bool available = await speechToText.initialize(
        onStatus: (status) {
          debugPrint('Speech status: $status');
          isListening.value = speechToText.isListening;
        },
        onError: (error) {
          debugPrint('Speech error: $error');
          isListening.value = false;
        },
      );

      if (available) {
        isListening.value = true;
        speechToText.listen(
          onResult: (result) {
            lastWords.value = result.recognizedWords;
            productNameController.text = lastWords.value;
            additionalInfoController.text = lastWords.value;
          },
          listenFor:
              const Duration(seconds: 60), // ⬅ Increase the duration here
          pauseFor: const Duration(seconds: 3),
          localeId: currentLocaleId,
        );
      } else {
        isListening.value = false;
        stt.SpeechToText().stop();
        debugPrint("The user has denied the use of speech recognition.");
      }
    } else {
      debugPrint("Microphone permission denied.");
    }
  }

  void stopVoiceRecognition() {
    isListening.value = false;
    stt.SpeechToText().stop();
  }

  /// Validate input and handle product creation API call
  Future<MCreateOffer?> createItem() async {
    isLoading.value = true;
    update();

    Map<String, dynamic> body = {
      "name": productNameController.text.trim(),
      "unit": selectedUnit.value,
      "quantity": quantity.value,
    };

    if (additionalInfoController.text.trim().isNotEmpty) {
      body["additionalinfo"] = additionalInfoController.text.trim();
    }

    try {
      var response = await ApiService.postApi(Urls.createOrders, body)
          .timeout(const Duration(seconds: 30));

      if (response != null) {
        MCreateOffer orderResponse = MCreateOffer.fromJson(response);

        if (orderResponse.success) {
          // Access the productId for the single product in the data field
          debugPrint(orderResponse.data.id); // This prints the productId

          // Add the created order details
          controller.addOrder(Product(
            name: productNameController.text.trim(),
            unit: selectedUnit.value,
            quantity: quantity.value,
            additionalInfo: additionalInfoController.text.trim(),
            delivery: true,
            availability: true,
            id: orderResponse.data.id,
            v: orderResponse.data.v,
            createdAt: orderResponse.data.createdAt,
            updatedAt: orderResponse.data.updatedAt,
          ));

          // Clear fields
          productNameController.clear();
          additionalInfoController.clear();
          quantity.value = 1;
          selectedUnit.value = 'Pcs';

          Get.snackbar('Success', 'Product created successfully.');

          // Navigate to Saved Order Screen
          Get.to(() => RetailerSavedOrderScreen(), arguments: orderResponse);

          return orderResponse;
        } else {
          Get.snackbar('Error', orderResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Invalid response from server.');
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar('Error', 'Order creation failed. Please try again.');
    } finally {
      isLoading.value = false;
      update();
    }

    return null;
  }

  @override
  void onClose() {
    productNameController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }
}

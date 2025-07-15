import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

import 'package:http_parser/http_parser.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:mime/mime.dart';

import '../models/api_response_model.dart';

class ApiService {
  ///<<<======================== Main Header ==============================>>>

  static const int timeOut = 120;

  ///<<<======================== Post Api ==============================>>>

  static Future<dynamic> postApi(String url, Map<String, dynamic> body,
      {Map<String, String>? header, int sucess = 200}) async {
    try {
      final token =
          await PrefsHelper.getToken(); // Retrieve token asynchronously

      Map<String, String> mainHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      if (kDebugMode) {
        print("==================================================> url $url");
        print("==================================================> body $body");
        print(
            "=======================================> header ${header ?? mainHeader} ");
      }

      final response = await http
          .post(Uri.parse(url),
              body: jsonEncode(body), headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));

      if (kDebugMode) {
        print(
            "==================================================> statusCode ${response.statusCode}");
        print(
            "==================================================> body ${response.body}");
      }
      if (response.statusCode == sucess) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // New function for sending a list of objects
  static Future<dynamic> postApiList(
      String url, List<Map<String, dynamic>> bodyList) async {
    try {
      String? token = await PrefsHelper.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      String requestBody = jsonEncode(bodyList);

      debugPrint(
          "==================================================> url $url");
      debugPrint(
          "==================================================> body $requestBody");
      debugPrint("=======================================> header $headers");

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody,
      );

      debugPrint(
          "==================================================> statusCode ${response.statusCode}");
      debugPrint(
          "==================================================> body ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body); // Return the error body
      }
    } catch (e) {
      debugPrint("Error in postApiList: $e");
      return null;
    }
  }

  // static ApiResponseModel handleResponse(http.Response response) {
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     return ApiResponseModel(
  //         response.statusCode, "Success", response.body);
  //   } else {
  //     return ApiResponseModel(response.statusCode,
  //         json.decode(response.body)['message'], response.body);
  //   }
  // }

  ///<<<======================== Get Api ==============================>>>

  static Future<dynamic> getApi(String url,
      {Map<String, String>? header, int sucess = 200}) async {
    try {
      // Retrieve token correctly
      String? token = await PrefsHelper.getToken();

      if (token.isEmpty) {
        Get.snackbar("Error", "User is not authenticated. Please log in.");
        throw Exception("JWT Token not found");
      }

      // Correctly set the Authorization header
      Map<String, String> mainHeader = {
        'Authorization': 'Bearer $token', // Fix: Use retrieved token correctly
        'Content-Type': 'application/json',
      };

      if (kDebugMode) {
        print("==================================================> url $url");
        print(
            "================================> header ${header ?? mainHeader}");
      }

      final response = await http
          .get(Uri.parse(url), headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));

      if (response.statusCode == sucess) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  ///<<<======================== Put Api ==============================>>>

  static Future<ApiResponseModel> putApi(String url, Map<String, String> body,
      {Map<String, String>? header}) async {
    dynamic responseJson;

    Map<String, String> mainHeader = {
      'Authorization': PrefsHelper.token,
    };

    if (kDebugMode) {
      print("==================================================> url $url");
      print("==================================================> url $body");
      print(
          "=======================================> url $header ?? $mainHeader");
    }

    try {
      final response = await http
          .put(Uri.parse(url), body: body, headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
    return responseJson;
  }

  ///<<<======================== Patch Api ==============================>>>

  static Future<dynamic> patchApi(String url, Map<String, dynamic> body,
      {Map<String, String>? header, int success = 200}) async {
    try {
      final token =
          await PrefsHelper.getToken(); // Retrieve token asynchronously

      Map<String, String> mainHeader = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      if (kDebugMode) {
        print("==================================================> url $url");
        print("==================================================> body $body");
        print(
            "=======================================> header ${header ?? mainHeader} ");
      }

      final response = await http
          .patch(Uri.parse(url), // Use PATCH instead of POST
              body: jsonEncode(body),
              headers: header ?? mainHeader)
          .timeout(const Duration(seconds: timeOut));

      if (kDebugMode) {
        print(
            "==================================================> statusCode ${response.statusCode}");
        print(
            "==================================================> body ${response.body}");
      }

      if (response.statusCode == success) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  ///<<<======================== Delete Api ==============================>>>

  static Future<ApiResponseModel> deleteApi(String url, Map map,
      {Map<String, String>? body, Map<String, String>? header}) async {
    dynamic responseJson;

    String? token = await PrefsHelper.getToken();

    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "User is not authenticated. Please log in.");
      throw Exception("JWT Token not found");
    }

    // Correctly set the Authorization header
    Map<String, String> mainHeader = {
      'Authorization': 'Bearer $token', // Fix: Use retrieved token correctly
      'Content-Type': 'application/json',
    };

    if (kDebugMode) {
      print("==================================================> url $url");
      print("==================================================> body $body");
      print(
          "==================================> header ${header ?? mainHeader}");
    }

    try {
      if (body != null) {
        final response = await http
            .delete(Uri.parse(url),
                body: jsonEncode(body), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      } else {
        final response = await http
            .delete(Uri.parse(url), headers: header ?? mainHeader)
            .timeout(const Duration(seconds: timeOut));
        responseJson = handleResponse(response);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad response request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request time out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }

    return responseJson;
  }

  ///<<<======================= Multipart Request ============================>>>

  static Future<ApiResponseModel> signUpMultipartRequest(
      {required String url,
      String? imagePath,
      required Map<String, String> body,
      required String otp}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);
        var img = await http.MultipartFile.fromPath('image', imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }

      request.headers["Otp"] = "OTP $otp";

      var response = await request.send();

      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(200, "", data);
      } else {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(response.statusCode, "", data);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
  }

  ///<<<================== Api Response Status Code Handle ====================>>>

  static ApiResponseModel handleResponse(http.Response response) {
    if (kDebugMode) {
      print(
          "==================================================> statusCode ${response.statusCode}");
      print(
          "==================================================> body ${response.body}");
    }
    appLogger(response.body);
    appLogger(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return ApiResponseModel(response.statusCode, "", response.body);
      case 201:
        return ApiResponseModel(response.statusCode, "", response.body);
      case 401:
        Get.offAllNamed(AppRoutes.signinScreen);
        return ApiResponseModel(response.statusCode, "", response.body);
      case 400:
        return ApiResponseModel(response.statusCode, "", response.body);
      case 404:
        return ApiResponseModel(response.statusCode, "", response.body);
      case 409:
        return ApiResponseModel(response.statusCode, "", response.body);
      default:
        return ApiResponseModel(response.statusCode, "", response.body);
    }
  }

  static Future<ApiResponseModel?> multipartRequest({
    required String url,
    String method = "POST",
    String? imagePath,
    String imageName = 'image',
    required Map<String, dynamic> body,
    Map<String, String>? header,
    int success = 200,
  }) async {
    try {
      // Default headers with Authorization
      Map<String, String> mainHeader = {
        'Authorization': PrefsHelper.token,
        'Content-Type':
            'multipart/form-data', // Required for multipart requests
      };

      if (kDebugMode) {
        print("==================================================> url $url");
        print("==================================================> body $body");
        print(
            "=======================================> header ${header ?? mainHeader} ");
      }

      // Create a multipart request
      var request = http.MultipartRequest(method, Uri.parse(url));

      // Add headers
      request.headers.addAll(header ?? mainHeader);

      // Add body fields
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // If there's an image path, add it as a multipart file
      if (imagePath != null && imagePath.isNotEmpty) {
        File imageFile = File(imagePath);
        if (await imageFile.exists()) {
          request.files.add(
              await http.MultipartFile.fromPath(imageName, imageFile.path));
        } else {
          debugPrint("Image file not found at path: $imagePath");
        }
      }

      // Send the request
      var response = await request.send().timeout(const Duration(seconds: 30));

      // Read the response body from the stream
      var responseBody = await response.stream.bytesToString();

      if (kDebugMode) {
        print(
            "==================================================> statusCode ${response.statusCode}");
        print(
            "==================================================> body $responseBody");
      }

      // Check if the response was successful
      if (response.statusCode == success) {
        return ApiResponseModel(
          response.statusCode, // status code
          "Request Successful", // message (can be customized based on your needs)
          jsonDecode(responseBody), // body (decoded JSON)
        );
      } else {
        return ApiResponseModel(
          response.statusCode, // status code
          "Request Failed", // message
          null, // body is null for failed request
        );
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<ApiResponseModel> addOrderRequest({
    required String url,
    method = "POST",
    String? imagePath,
    required List surfaceFile,
    imageName = 'image',
    required body,
    Map<String, String>? header,
  }) async {
    try {
      Map<String, String> mainHeader = {
        'Authorization': PrefsHelper.token,
      };

      if (kDebugMode) {
        print("===============================================>url $url");
        print("===============================================>body $body");
        print("=========================>header ${header ?? mainHeader}");
      }

      var request = http.MultipartRequest(method, Uri.parse(url));
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      int value = 0;

      for (var item in surfaceFile) {
        var mimeType = lookupMimeType(item ?? imagePath);
        var shopImage = await http.MultipartFile.fromPath(
            "surfaceImage$value", item ?? " ",
            contentType: MediaType.parse(mimeType!));
        request.files.add(shopImage);
        value++;
      }

      if (imageName != null) {
        var mimeType = lookupMimeType(imagePath!);
        var shopImage = await http.MultipartFile.fromPath(
            "coverImage", imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(shopImage);
      }

      Map<String, String> headers = header ?? mainHeader;

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      var response = await request.send();

      if (kDebugMode) {
        print(
            "===============================================>statusCode ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        String data = await response.stream.bytesToString();

        return ApiResponseModel(200, jsonDecode(data)['message'], data);
      } else if (response.statusCode == 201) {
        String data = await response.stream.bytesToString();

        return ApiResponseModel(200, jsonDecode(data)['message'], data);
      } else {
        String data = await response.stream.bytesToString();
        return ApiResponseModel(
            response.statusCode, jsonDecode(data)['message'], data);
      }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    } on TimeoutException {
      return ApiResponseModel(408, "Request Time Out", "");
    } catch (e) {
      return ApiResponseModel(400, e.toString(), "");
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:inventory_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper extends GetxController {
  static String token = "";
  static bool isLogIn = false;
  static bool isNotifications = true;
  static String userRole = ""; // Default role
  static String userId = "";
  static String emailId = ""; 
  static String myImage = "";
  static String myName = "";
  static String productId = ""; // Keep productId field here
  static String mySubscription = "shopping";
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';

  // Save the selected product ID
  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token") ?? "";
    userId = preferences.getString("userId") ?? ""; 
    emailId = preferences.getString("email") ?? "";
    myImage = preferences.getString("image") ?? "";
    myName = preferences.getString("name") ?? "";
    productId = preferences.getString("_id") ?? "";
    userRole = preferences.getString("userRole") ?? "";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    isNotifications = preferences.getBool("isNotifications") ?? true;
    mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode =
        preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode =
        preferences.getString("localizationLanguageCode") ?? "en";

    if (kDebugMode) {
      print("===============UserRole: $userRole====================");
    }

    if (kDebugMode) {
      print("===============email: $emailId====================");
    }
  }

  // <<<======================== Save User Role =============================>>>
  static Future<void> saveUserRole(String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userRole", role);
    userRole = role; // Store it in memory as well
  }

  //<<<=======================================User Email===============================>>>

  static Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailId); 
    emailId = email; 
  }

  

  // <<<======================== Get User ID =============================>>>
  // static Future<String?> get userId async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('userId'); // Ensure this key is correct
  // }

  // static Future<void> setUserId(String userId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', userId);  // Save userId to shared preferences
  //   _userId = userId; // Store userId in memory as well
  // }

  // <<<======================== Get token =============================>>>
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Return empty string if no token
  }

  static String getUserRole() {
    return userRole.isNotEmpty
        ? userRole
        : ""; // Default to "retailer" if not found
  }

  // <<<======================== Remove All Data From Shared Preferences ============>>>
  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setString("token", "");
    preferences.setString("userRole", ""); // Clear role
    preferences.setBool("isLogIn", false);
    preferences.setBool("isNotifications", true);
    preferences.setString("mySubscription", "shopping");

    Get.offAllNamed(AppRoutes.signinScreen);
    getAllPrefData();
  }

  //<<<======================== Get Data From Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  //<<<===================== Save Data To Shared Preference ======================>

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  //<<<========================== Remove Value ==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  // Store and retrieve productId
  static Future<void> setProductId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        "_id", id); // Store productId with the correct key "_id"
    productId = id; // Store in memory as well
    print("Stored Product ID: $id");
  }

  static Future<String?> getProductId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences
        .getString("_id"); // Retrieve productId with the correct key "_id"
  }
}

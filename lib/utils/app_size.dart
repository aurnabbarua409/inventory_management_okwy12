import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static double screenHeight = 0;
  static double screenWidth = 0;

  static void initialize(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
  }

  // Function to calculate responsive height
  static double height(double height) {
    return screenHeight / (screenHeight / height);
  }

  // Function to calculate responsive width
  static double width(double width) {
    return screenWidth / (screenWidth / width);
  }
}

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath; // This will now receive a string (URL or asset path)

  const ImageWidget({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    }
  }
}

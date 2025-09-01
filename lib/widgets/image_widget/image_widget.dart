import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/utils/app_urls.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath; // This will now receive a string (URL or asset path)
  final bool fromNetwork;
  const ImageWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.imagePath,
      this.fromNetwork = false});

  @override
  Widget build(BuildContext context) {
    if (fromNetwork) {
      return Image.network("${Urls.socketUrl}$imagePath",
          height: height,
          width: width,
          fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppImagesPath.profileImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      });
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

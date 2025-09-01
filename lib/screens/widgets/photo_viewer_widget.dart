import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/constants/app_images_path.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerWidget extends StatelessWidget {
  const PhotoViewerWidget({super.key, required this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Dialog(
            insetPadding: const EdgeInsets.all(0),
            backgroundColor: Colors.black,
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: NetworkImage(
                    "${Urls.socketUrl}${url ?? ""}",
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  initialScale: PhotoViewComputedScale.contained,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: SizedBox(
        height: 30,
        width: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            "${Urls.socketUrl}${url ?? ""}",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AppImagesPath.profileImage);
            },
          ),
        ),
      ),
    );
  }
}

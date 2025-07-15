import 'package:flutter/material.dart';

import '../../../constants/app_images_path.dart';

class MainAppbarWidget extends StatelessWidget {
  final Widget child;

  const MainAppbarWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 24),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImagesPath.splashBg),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: child,
    );
  }
}

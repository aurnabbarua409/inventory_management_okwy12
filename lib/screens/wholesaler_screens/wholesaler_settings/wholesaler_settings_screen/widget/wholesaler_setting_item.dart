import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_strings.dart';

class WholesalerSettingItem extends StatelessWidget {
  const WholesalerSettingItem({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    required this.onTap,
  });
  final Widget leading;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: title == AppStrings.logOut
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

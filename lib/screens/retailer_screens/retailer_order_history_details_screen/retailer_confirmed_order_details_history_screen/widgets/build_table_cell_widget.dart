import 'package:flutter/material.dart';
import 'package:inventory_app/utils/app_size.dart';

class BuildTableCellWidget extends StatelessWidget {
  const BuildTableCellWidget(this.text,
      {super.key, this.flex = 1, this.isHeader = false});
  final String text;
  final int flex;
  final bool isHeader;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(8.0)),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
          softWrap: true,
        ),
      ),
    );
  }
}

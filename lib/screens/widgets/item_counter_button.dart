import 'package:flutter/material.dart';
import 'package:inventory_app/constants/app_colors.dart';
import 'package:inventory_app/utils/app_size.dart';

class ItemCount extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final ValueChanged<int> onChanged;

  const ItemCount({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.onChanged,
  });

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _currentValue += 1; // No max limit
    });
    widget.onChanged(_currentValue);
  }

  void _decrement() {
    if (_currentValue > widget.minValue) {
      setState(() {
        _currentValue -= 1;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyDark100, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement Button
          IconButton(
            icon: const Icon(Icons.remove),
            color: AppColors.white,
            iconSize: 22,
            onPressed: _decrement,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: const CircleBorder(),
            ),
          ),
          // Counter Display (Now Displays Whole Numbers)
          Container(
            width: ResponsiveUtils.width(70),
            alignment: Alignment.center,
            child: Text(
              _currentValue.toString(), // Ensures integer display
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Increment Button
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            iconSize: 22,
            onPressed: _increment,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

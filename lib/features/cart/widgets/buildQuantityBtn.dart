import 'package:flutter/material.dart';

// Helper Widget for Quantity Buttons (+/-)
Widget buildQuantityBtn(IconData icon, {required bool isDark}) {
  return Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      color: isDark ? Colors.black : Colors.transparent,
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      size: 16,
      color: isDark ? Colors.white : Colors.black54,
    ),
  );
}

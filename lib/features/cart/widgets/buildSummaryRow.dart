import 'package:flutter/material.dart';


// Helper Widget for Subtotal/Shipping Rows
Widget buildSummaryRow(String label, String value, {Color? valueColor, bool isValueBold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isValueBold ? FontWeight.bold : FontWeight.w600,
          color: valueColor ?? Colors.black,
        ),
      ),
    ],
  );
}
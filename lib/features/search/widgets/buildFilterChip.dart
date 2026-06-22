import 'package:flutter/material.dart';

Widget buildFilterChip(String label, {bool isSelected = false, bool hasDropdown = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: isSelected ? Colors.black : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: isSelected ? null : Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        if (hasDropdown) ...[
          const SizedBox(width: 6),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Colors.black87,
          ),
        ]
      ],
    ),
  );
}

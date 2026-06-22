// Helper Widget for Trending Products
import 'package:flutter/material.dart';

Widget buildProductCard({
  required String tag,
  required String title,
  required String price,
  required Color imageColor,
  bool isDarkBackground = false,
}) {
  return SizedBox(
    width: 170,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container Placeholder
        Container(
          height: 170,
          width: 170,
          decoration: BoxDecoration(
            color: imageColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              color: isDarkBackground ? Colors.white30 : Colors.black26,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          tag,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}
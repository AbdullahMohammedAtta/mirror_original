
// Helper Widget for Recent Search Rows
import 'package:flutter/material.dart';

Widget buildRecentSearchItem(String query) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      children: [
        const Icon(Icons.history, color: Colors.grey),
        const SizedBox(width: 16),
        Text(
          query,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1A202C),
          ),
        ),
      ],
    ),
  );
}

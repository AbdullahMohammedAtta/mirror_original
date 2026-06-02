import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Column(
      children: [
        const Text(
          'ABU MOUSA',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        Container(width: 70, height: 2, color: Colors.black),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border_outlined, color: Colors.black),
      ),
      const SizedBox(width: 10),
    ],
  );
}

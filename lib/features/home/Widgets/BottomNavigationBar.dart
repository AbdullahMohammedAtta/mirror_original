import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

import 'NavItem.dart';

Widget buildBottomNavigationBar(HomeCubit homeCubit) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: const BoxDecoration(color: Colors.white),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildNavItem(homeCubit, Icons.home_outlined, 'Home', 0),
        buildNavItem(homeCubit, Icons.search, 'Search', 1),
        buildNavItem(homeCubit, Icons.shopping_cart_outlined, 'Cart', 2),
        buildNavItem(homeCubit, Icons.person_outline, 'Profile', 3),
      ],
    ),
  );
}

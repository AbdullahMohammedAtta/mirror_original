import 'package:flutter/material.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/favourites/view/favourite_page.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

PreferredSizeWidget buildAppBar(context, HomeCubit homeCubit) {
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
      Stack(
        children: [
          IconButton(
            onPressed: () {
              navigateTo(context, FavouritePage(homeCubit));
            },
            icon: const Icon(Icons.favorite_border_outlined, color: Colors.black),
          ),
          if(homeCubit.favoriteIds.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(100),
              shape: BoxShape.circle,
              color: Colors.red

            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text("${homeCubit.favoriteIds.length}",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
      const SizedBox(width: 10),
    ],
  );
}

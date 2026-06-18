import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/cart/widgets/buildCartItem.dart';
import 'package:mirror_original/features/cart/widgets/buildSummaryRow.dart';
import 'package:mirror_original/features/favourites/widgets/build_favourite_item.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

class FavouriteBodyWidget extends StatelessWidget {
  const FavouriteBodyWidget({super.key, required this.homeCubit});
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Text(
            'My Favourites',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${homeCubit.favoriteIds.length} items in your collection',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 32),

          // Cart Items List
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Padding(padding: EdgeInsetsGeometry.all(8), child: myDivider()),
            itemBuilder: (context, index) {

              return buildFavouriteItem(
                  context: context,
                  product: homeCubit.favoriteProducts[index],
                  homeCubit: homeCubit,
              );
            },
            itemCount: homeCubit.favoriteIds.length,
          ),
          const SizedBox(height: 24),

        ],
      ),
    );
  }



}
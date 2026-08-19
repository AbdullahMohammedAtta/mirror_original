import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/Widgets/ProductCard.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

Widget buildProductGrid(
    List<ProductModel> products,
    HomeCubit homeCubit, {
      ScrollPhysics physics = const NeverScrollableScrollPhysics(),
    }) {
  // Find Trending category
  final trendingCategory = homeCubit.categories.firstWhere(
        (category) => category.name == 'Trending',
  );

  // Get only products that belong to Trending
  final trendingProducts = products
      .where((product) => product.categoryId == trendingCategory.id)
      .toList();

  return GridView.builder(
    shrinkWrap: true,
    physics: physics,
    itemCount: trendingProducts.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      childAspectRatio: 0.56,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return buildProductCard(
        trendingProducts[index],
        homeCubit,
        context,
      );
    },
  );
}
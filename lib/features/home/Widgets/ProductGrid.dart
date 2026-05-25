import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/Widgets/ProductCard.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

Widget buildProductGrid(List<ProductModel> products) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.54,
      crossAxisSpacing: 14,
      mainAxisSpacing: 16,
    ),
    itemBuilder: (context, index) {
      return buildProductCard(products[index],context);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/Widgets/ProductCard.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

Widget buildProductGrid(List<ProductModel> products) {

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      childAspectRatio: 0.60,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return buildProductCard(products[index],context);
    },
  );
}

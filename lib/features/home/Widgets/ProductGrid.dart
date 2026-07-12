import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/Widgets/ProductCard.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

Widget buildProductGrid(List<ProductModel> products,HomeCubit homeCubit,{ScrollPhysics physics = const NeverScrollableScrollPhysics()}) {

  return GridView.builder(
    shrinkWrap: true,
    physics: physics,
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      childAspectRatio: 0.56,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return buildProductCard(products[index],homeCubit,context);
    },
  );
}

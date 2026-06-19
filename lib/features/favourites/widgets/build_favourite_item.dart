import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view/profuct_details.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

Widget buildFavouriteItem({
  required HomeCubit homeCubit,
  required ProductModel product,
  required context,
}) {
  return InkWell(
    onTap: (){
      navigateTo(context, ProductDetailPage(product));
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image Placeholder
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            color: const Color(0xFFEAEAEA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: ConditionalBuilder(
              condition: product.mainImage != '' ,
              fallback: (context) => Icon(
                Icons.snowshoeing, // Placeholder icon
                color: Colors.grey.shade400,
                size: 40,
              ),
              builder: (context) {
                return Image.network(product.mainImage) ;
              },
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Trash Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      homeCubit.toggleFavorite(product.id);
                    },
                    child: Icon(
                        homeCubit.favoriteIds.contains(product.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 22
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Brand
              Text(
                "${product.brand}",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              // Price and
              Text(
                "${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
// Helper Widget for individual cart items
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/cart/widgets/buildQuantityBtn.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view/profuct_details.dart';

Widget buildCartItem({
  required ProductModel product,
  required context,
  required String quantity,
  required String size,
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
                  const Icon(
                    Icons.delete_outline,
                    color: Colors.black87,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Size
              Text(
                'SIZE: $size',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Price and Quantity Adjuster
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Quantity Pill
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FE), // Light blue tint
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      children: [
                        buildQuantityBtn(Icons.remove, isDark: false),
                        const SizedBox(width: 16),
                        Text(
                          quantity,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        buildQuantityBtn(Icons.add, isDark: true),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
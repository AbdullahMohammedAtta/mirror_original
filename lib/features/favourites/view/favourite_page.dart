import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Row(
          children: [
            Text('WishList',),
            SizedBox(width: 5,),
            Icon(Icons.list_alt_outlined),
          ],
        ),
      ),
      body: ConditionalBuilder(
          condition: true,
          fallback: (context) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.favorite_border_rounded,size: 250,weight: 0.3,),
                    ],
                  ),
                  Text(
                    'No products in the wishlist !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
          builder: (context) {
            return CartBodyWidget();
          },
      ),
    );
  }
}


class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

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
            'My Favourite',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '3 items in your collection',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          myDivider(),
          const SizedBox(height: 20),

          // Cart Items List
          _buildCartItem(
            name: 'Velocita Pro v2',
            size: 'EU 42',
            price: '\$240.00',
            quantity: '1',
          ),
          const SizedBox(height: 24),
          _buildCartItem(
            name: 'AeroStrider Core',
            size: 'EU 44',
            price: '\$185.00',
            quantity: '1',
          ),
          const SizedBox(height: 24),
          _buildCartItem(
            name: 'Crimson Surge',
            size: 'EU 41',
            price: '\$310.00',
            quantity: '2',
          ),

          const SizedBox(height: 32),

          // Divider
          myDivider(),
        ],
      ),
    );
  }

  // Helper Widget for individual cart items
  Widget _buildCartItem({
    required String name,
    required String size,
    required String price,
    required String quantity,
  }) {
    return Row(
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
            child: Icon(
              Icons.snowshoeing, // Placeholder icon
              color: Colors.grey.shade400,
              size: 40,
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
                    name,
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
                    price,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

}
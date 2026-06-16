import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view/profuct_details.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage(HomeCubit this.homeCubit, {super.key});
  final HomeCubit homeCubit;

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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: homeCubit.favoriteIds.isNotEmpty,
            fallback: (context) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded,size: 250),
                    Text('No products in the wishlist !'),
                  ],
                ),
              );
            },
            builder: (context) {
              return CartBodyWidget(homeCubit);
            },
          );
        },
      ),
    );
  }
}


class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget(HomeCubit this.homeCubit, {super.key, });
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
            'My Favourite',
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
          const SizedBox(height: 20),
          //myDivider(),
          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeCubit.favoriteProducts.length,
            separatorBuilder: (_, __) => myDivider(),
            itemBuilder: (context, index) {
              final ProductModel product = homeCubit.favoriteProducts[index];

              return _buildCartItem(
                homeCubit: homeCubit,
                product: product,
                context: context
              );
            },
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
    required ProductModel product,
    required HomeCubit homeCubit,
    context,

  }) {
    return InkWell(
      onTap: ()
      {
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
            child:Image.network(product.mainImage,fit: BoxFit.cover,),
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
                    IconButton(
                        onPressed: ()
                    async {
                      await homeCubit.toggleFavorite(product.id);
                    },
                        icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black87,
                      size: 20,
                    )),
                  ],
                ),
                const SizedBox(height: 4),

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

}
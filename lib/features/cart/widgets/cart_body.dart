import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/cart/widgets/buildCartItem.dart';
import 'package:mirror_original/features/cart/widgets/buildSummaryRow.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key, required this.homeCubit});
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
            'My Cart',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${homeCubit.cartItems.length} items in your collection',
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

              final cartItem = homeCubit.cartItems[index];

              final product = homeCubit.products.firstWhere(
                    (p) => p.id == cartItem.productId,
              );

              return buildCartItem(
                homeCubit: homeCubit,
                context: context,
                product: product,
                quantity: '1',
                size: '40'
              );
            },
              itemCount: homeCubit.cartItems.length,
          ),
          const SizedBox(height: 24),


          const SizedBox(height: 32),

          // Divider
          myDivider(),

          const SizedBox(height: 24),

          // Order Summary Section
          buildSummaryRow('Subtotal', '\$1,045.00'),
          const SizedBox(height: 16),
          buildSummaryRow(
            'Shipping',
            'Free',
            valueColor: const Color(0xFF1B6A47), // Dark teal/green color
            isValueBold: true,
          ),
          const SizedBox(height: 28),

          // Total Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$1,045.00',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Checkout Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}
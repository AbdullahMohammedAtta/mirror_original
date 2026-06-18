import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/cart/widgets/buildCartItem.dart';
import 'package:mirror_original/features/cart/widgets/buildSummaryRow.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {

        if (state is AddToCartSuccessState) {
          showToast(
            message: 'Added to cart successfully',
            state: ToastState.success,
          );
        }

        if (state is AddToCartErrorState) {
          showToast(
            message: state.error,
            state: ToastState.error,
          );
        }
      },

      builder: (context, state) {
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
                const Text(
                  '3 items in your collection',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),

                // Cart Items List
                buildCartItem(
                  name: 'Velocita Pro v2',
                  size: 'EU 42',
                  price: '\$240.00',
                  quantity: '1',
                ),
                const SizedBox(height: 24),
                buildCartItem(
                  name: 'AeroStrider Core',
                  size: 'EU 44',
                  price: '\$185.00',
                  quantity: '1',
                ),
                const SizedBox(height: 24),
                buildCartItem(
                  name: 'Crimson Surge',
                  size: 'EU 41',
                  price: '\$310.00',
                  quantity: '2',
                ),

                const SizedBox(height: 32),

                // Divider
                Divider(color: Colors.grey.shade300, thickness: 1),

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
        },
    );
  }



}
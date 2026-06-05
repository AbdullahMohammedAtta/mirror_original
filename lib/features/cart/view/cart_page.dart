import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ConditionalBuilder(
        condition: true,
        fallback: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,size: 200,),
                const SizedBox(height: 10),
                const Text('   Your cart is empty now\nThank you for choosing us!',style: TextStyle(fontSize: 16),),
                const SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  child: MaterialButton(
                    onPressed: (){

                    },
                    child: const Text(
                      'Shop Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        builder: (context) {
          return CartBodyWidget();
        },
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
          Divider(color: Colors.grey.shade300, thickness: 1),

          const SizedBox(height: 24),

          // Order Summary Section
          _buildSummaryRow('Subtotal', '\$1,045.00'),
          const SizedBox(height: 16),
          _buildSummaryRow(
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
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      children: [
                        _buildQuantityBtn(Icons.remove, isDark: false),
                        const SizedBox(width: 16),
                        Text(
                          quantity,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildQuantityBtn(Icons.add, isDark: true),
                      ],
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

  // Helper Widget for Quantity Buttons (+/-)
  Widget _buildQuantityBtn(IconData icon, {required bool isDark}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 16,
        color: isDark ? Colors.white : Colors.black54,
      ),
    );
  }

  // Helper Widget for Subtotal/Shipping Rows
  Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isValueBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isValueBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
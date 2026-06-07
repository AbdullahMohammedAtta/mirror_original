import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA), // Light grayish background
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                alignLabelWithHint: true,
                hint: Text(
                  'Search sneakers...',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
                icon:Icon(Icons.search,color: Colors.grey.shade500),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Filters Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All Results', isSelected: true),
                const SizedBox(width: 12),
                _buildFilterChip('Price', hasDropdown: true),
                const SizedBox(width: 12),
                _buildFilterChip('Brand', hasDropdown: true),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Trending Now Section Title
          const Text(
            'Trending Now',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),

          // Trending Now Product Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildProductCard(
                  tag: 'LIMITED EDITION',
                  title: 'Cloud Runner X',
                  price: '\$280.00',
                  imageColor: const Color(0xFFDFE1E0), // Placeholder color
                ),
                const SizedBox(width: 16),
                _buildProductCard(
                  tag: 'NEW ARRIVAL',
                  title: 'Vortex Prime',
                  price: '\$310.00',
                  imageColor: const Color(0xFF1E2226), // Placeholder color
                  isDarkBackground: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Recent Searches Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A202C),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Clear All Action
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Recent Search Items
          _buildRecentSearchItem('Air Max Premium'),
          Divider(color: Colors.grey.shade200, height: 1),
          _buildRecentSearchItem('Suede Originals'),
        ],
      ),
    );
  }

  // Helper Widget for Filter Chips
  Widget _buildFilterChip(String label, {bool isSelected = false, bool hasDropdown = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          if (hasDropdown) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.black87,
            ),
          ]
        ],
      ),
    );
  }

  // Helper Widget for Trending Products
  Widget _buildProductCard({
    required String tag,
    required String title,
    required String price,
    required Color imageColor,
    bool isDarkBackground = false,
  }) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container Placeholder
          Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                color: isDarkBackground ? Colors.white30 : Colors.black26,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            tag,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Recent Search Rows
  Widget _buildRecentSearchItem(String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.grey),
          const SizedBox(width: 16),
          Text(
            query,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1A202C),
            ),
          ),
        ],
      ),
    );
  }
}
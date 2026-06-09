import 'package:flutter/material.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Off-white background
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image Header Section
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height*0.36,
                child: Stack(
                  children: [
                    // Sneaker Image Placeholder
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height*0.36,
                      child: Image.network(product.mainImage, fit: BoxFit.cover,),
          
                    ),
                    IconButton(onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                        icon: Container(
                          height: 40,
                          width: 40,
                          decoration:BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.arrow_back,),
                        ))
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18), // أقل شوية من الكونتينر
                          child: Image.network(
                            product.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );;
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 3,),
                    itemCount: product.images.length,
                  ),
                ),
              ),
          
              // 2. Product Info Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${product.category}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 10),
                               Text(
                                '${product.title}\n " ${product.brand} "',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(onPressed: (){}, icon: Icon(
                            Icons.favorite_border,
                            size: 28,
                          ),)
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '${product.price} Egp',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (product.oldPrice != 0)
                          Text(
                            '${product.oldPrice}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 18,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 30),
          
                    // 3. Size Selection Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Select Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Size Guide',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                            return _buildSizeButton(product.sizes[index].toString(), false);
                          },
                        separatorBuilder: (context, index) => SizedBox(width: 3,),
                        itemCount: product.sizes.length,
                      ),
                    ),
                    const SizedBox(height: 30),
          
                    // 4. Product Story Section
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${product.description}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Divider
                    myDivider(),
                    const SizedBox(height: 20),
                    // 5. Perks Section
                    _buildPerkRow(Icons.local_shipping_outlined, 'Complimentary Express Shipping'),
                    const SizedBox(height: 16),
                    _buildPerkRow(Icons.verified_outlined, '100% Authenticity Guaranteed'),
                    const SizedBox(height: 40), // Bottom padding before safe area
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 6. Bottom Add to Cart Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: ElevatedButton(
          onPressed: () {
            print(product.images);
            print(product.category);
            print(product.colors);
            print(product.sizes);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.shopping_bag_outlined, size: 20),
              SizedBox(width: 10),
              Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Size Buttons
  Widget _buildSizeButton(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }

  // Helper Widget for Shipping/Authenticity Rows
  Widget _buildPerkRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
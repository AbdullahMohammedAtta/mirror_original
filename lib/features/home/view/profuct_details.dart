import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view/image_Page.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          int counter = 0;
          //this widget for make index = 0 when I back or pop from this page
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                homeCubit.productImagesIndex = 0;
              }
            },
            child: Scaffold(
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
                            GestureDetector(
                              onTap:()
                              {
                                navigateTo(context, ImagePage(homeCubit.selectedImage(product)));
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height*0.36,
                                child: Image.network(homeCubit.selectedImage(product), fit: BoxFit.cover,),
            
                              ),
                            ),
                            IconButton(onPressed: ()
                            {
                              Navigator.pop(context);
                              //homeCubit.productImagesIndex = 0;  عملتها فوق خلاص
                            },
                                icon: Container(
                                  height: 40,
                                  width: 40,
                                  decoration:BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(Icons.arrow_back_ios_sharp,),
                                ))
                          ],
                        ),
                      ),
            
                      SizedBox(height: 10,),
                      if(product.images.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            //shrinkWrap: true,
                            itemBuilder: (context, index) {
            
                              return GestureDetector(
                                onTap: ()
                                {
                                  homeCubit.changeImagesIndex(index);
                                },
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: index == homeCubit.productImagesIndex ? Colors.blue : Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      index == 0
                                          ? product.mainImage
                                          : product.images[index - 1],
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(width: 3,),
                            itemCount: product.images.length+1,
                          ),
                        ),
                      ),
            
                      // 2. Product Info Section
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height*0.15,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        '${product.title}\n"${product.brand}"',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              shape: BoxShape.circle,
                                            ),
                                            child: GestureDetector(
                                              onTap: (){
                                                homeCubit.toggleFavorite(product.id);
                                              },
                                              child: Icon(
                                                  homeCubit.favoriteIds.contains(product.id)
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red,
                                                  size: 28
                                              ),
                                            ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200, // Light blue tint
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (homeCubit.quantityCounter > 0) {
                                                      homeCubit.removeQuantityCounter();
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                      color:  Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  "${homeCubit.quantityCounter}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                InkWell(
                                                  onTap: (){
                                                    homeCubit.addQuantityCounter();
                                                  },
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 16,
                                                      color:  Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          );
        },
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




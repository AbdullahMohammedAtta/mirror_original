  import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';
import 'package:mirror_original/features/search/widgets/buildFilterChip.dart';
import 'package:mirror_original/features/search/widgets/buildRecentSearchItem.dart';
import 'package:mirror_original/features/search/widgets/buildSearchItem.dart';

import '../widgets/buildProductCard.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener:(context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);

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
                  onChanged: (value)
                  {
                    homeCubit.search(value);
                    print(homeCubit.searchProducts.toString());
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    hint: Text(
                      'Search sneakers...',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    icon: Icon(Icons.search, color: Colors.grey.shade500),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ConditionalBuilder(
                  condition: homeCubit.searchProducts.isNotEmpty ,
                  fallback: (context) {
                    return Column(
                      children: [
                        // Recent Searches Section Title
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Recent Searches',
                        //       style: TextStyle(
                        //         fontSize: 22,
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(0xFF1A202C),
                        //       ),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         // Clear All Action
                        //       },
                        //       child: const Text(
                        //         'Clear All',
                        //         style: TextStyle(
                        //           color: Colors.grey,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 8),
                        //
                        // // Recent Search Items
                        // buildRecentSearchItem('Air Max Premium'),
                        // myDivider(),
                        // buildRecentSearchItem('Suede Originals'),
                        //const SizedBox(height: 32),
                        // Filters Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildFilterChip('All Results', isSelected: true),
                              const SizedBox(width: 12),
                              buildFilterChip('Price', hasDropdown: true),
                              const SizedBox(width: 12),
                              buildFilterChip('Brand', hasDropdown: true),
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
                              buildProductCard(
                                tag: 'LIMITED EDITION',
                                title: 'Cloud Runner X',
                                price: '\$280.00',
                                imageColor: const Color(0xFFDFE1E0), // Placeholder color
                              ),
                              const SizedBox(width: 16),
                              buildProductCard(
                                tag: 'NEW ARRIVAL',
                                title: 'Vortex Prime',
                                price: '\$310.00',
                                imageColor: const Color(0xFF1E2226),
                                // Placeholder color
                                isDarkBackground: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                      ],
                    );
                    },
                  builder: (context) {
                    return buildSearchItem(homeCubit);
                  },
              )

            ],
          ),
        );
      },
    );
  }


}
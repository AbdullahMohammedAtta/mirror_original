import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/Widgets/Categories.dart';
import 'package:mirror_original/features/home/Widgets/ProductGrid.dart';
import 'package:mirror_original/features/home/Widgets/PromoBanner.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';



class homeBody extends StatelessWidget {
  const homeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! GetProductsLoadingState,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              return RefreshIndicator(
                onRefresh: (){
                  return homeCubit.getProducts();
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const SizedBox(height: 10),
                      //buildSearchBar(),
                      const SizedBox(height: 25),
                      buildPromoBanner(),
                      const SizedBox(height: 15),
                      myDivider(),
                      const SizedBox(height: 15),
                      buildCategories(),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending Now',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'View All',
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildProductGrid(homeCubit.products),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/Widgets/ProductGrid.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key, this.categoryId, this.categoryName});
  final String? categoryId;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          final categoryProducts = categoryId == null
              ? homeCubit.products
              : homeCubit.products
              .where((product) => product.categoryId == categoryId)
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: categoryId == null ? const Text('All Products') : Text('${categoryName}'),
              centerTitle: true,
            ),
            body: buildProductGrid(categoryProducts, homeCubit,physics: AlwaysScrollableScrollPhysics()),
          );
        },
    );
  }
}

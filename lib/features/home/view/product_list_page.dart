import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/Widgets/ProductGrid.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('All Products'),
              centerTitle: true,
            ),
            body: buildProductGrid(homeCubit.products, homeCubit,physics: AlwaysScrollableScrollPhysics()),
          );
        },
    );
  }
}

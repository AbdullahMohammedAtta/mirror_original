import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/cart/widgets/cart_body.dart';
import 'package:mirror_original/features/favourites/widgets/favourite_body.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage(HomeCubit this.homeCubit, {super.key});
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Row(
          children: [
            Text('WishList',),
            SizedBox(width: 5,),
            Icon(Icons.list_alt_outlined),
          ],
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: homeCubit.favoriteIds.isNotEmpty,
            fallback: (context) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded,size: 250),
                    Text('No products in the wishlist !'),
                  ],
                ),
              );
            },
            builder: (context) {
              return FavouriteBodyWidget(homeCubit: homeCubit,);
            },
          );
        },
      ),
    );
  }
}



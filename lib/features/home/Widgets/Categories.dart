import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';
import '../view_model/home_cubit.dart';

Widget buildCategories() {
  return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return SizedBox(
          height: MediaQuery.sizeOf(context).height*0.24,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //bool isSelected = homeCubit.selectedCategoriesIndex == index;
              return GestureDetector(
                onTap: () {
                  //homeCubit.changeCategories(index);
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.network(homeCubit.categories[index].image,fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        homeCubit.categories[index].name.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: homeCubit.categories.length,
          ),
        );
      },
  );
}

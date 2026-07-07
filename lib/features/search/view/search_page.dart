import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';
import 'package:mirror_original/features/search/widgets/buildSearchItem.dart';

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
                  fallback: (context){
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('What are you looking for ... 👌',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.grey),),
                    ));
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
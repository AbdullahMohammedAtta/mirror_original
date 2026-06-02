import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/widgets/myDivider.dart';
import 'package:mirror_original/features/home/Widgets/AppBar.dart';
import 'package:mirror_original/features/home/Widgets/BottomNavigationBar.dart';
import 'package:mirror_original/features/home/Widgets/Categories.dart';
import 'package:mirror_original/features/home/Widgets/ProductGrid.dart';
import 'package:mirror_original/features/home/Widgets/PromoBanner.dart';
import 'package:mirror_original/features/home/Widgets/SearchBar.dart';
import 'package:mirror_original/features/home/Widgets/drawer.dart';
import 'package:mirror_original/features/home/Widgets/home_body.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          drawer: buildDrawer(context),
          appBar: buildAppBar(),
          body: homeCubit.screens[homeCubit.selectedNavBarIndex],
          bottomNavigationBar: buildBottomNavigationBar(homeCubit),
        );
      },
    );
  }
}











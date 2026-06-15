import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/Widgets/AppBar.dart';
import 'package:mirror_original/features/home/Widgets/BottomNavigationBar.dart';
import 'package:mirror_original/features/home/Widgets/drawer.dart';
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
          appBar: buildAppBar(context,homeCubit),
          body: homeCubit.screens[homeCubit.selectedNavBarIndex],
          bottomNavigationBar: buildBottomNavigationBar(homeCubit),
        );
      },
    );
  }
}











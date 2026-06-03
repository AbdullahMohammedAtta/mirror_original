import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/cart/view/cart_page.dart';
import 'package:mirror_original/features/home/Widgets/home_body.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';
import 'package:mirror_original/features/profile/view/profile_page.dart';
import 'package:mirror_original/features/search/view/search_page.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);



  List<String> categories = ['All', 'Running', 'Lifestyle'];
  int selectedCategoriesIndex = 0;

  void changeCategories(int index)
  {
    selectedCategoriesIndex = index;
    emit(ChangeCatState());
  }

  List<Widget> screens = [
    homeBody(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  int selectedNavBarIndex = 0;
  void changeNavBar(int index)
  {
    selectedNavBarIndex = index;
    emit(ChangeNavBarState());
  }



  


  

}
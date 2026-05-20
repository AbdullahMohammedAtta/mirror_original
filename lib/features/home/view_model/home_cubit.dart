import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';

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

  int selectedNavBarIndex = 0;

  void changeNavBar(int index)
  {
    selectedNavBarIndex = index;
    emit(ChangeNavBarState());
  }

}
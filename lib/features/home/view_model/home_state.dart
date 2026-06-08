abstract class HomeState {}

class HomeInitial extends HomeState{}


class ChangeCatState extends HomeState{}
class ChangeNavBarState extends HomeState{}



class GetProductsLoadingState extends HomeState {}
class GetProductsSuccessState extends HomeState {}
class GetProductsErrorState extends HomeState {
  final String error;

  GetProductsErrorState(this.error);
}
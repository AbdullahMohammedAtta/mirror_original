abstract class HomeState {}

class HomeInitial extends HomeState{}


class ChangeCatState extends HomeState{}
class ChangeNavBarState extends HomeState{}
class ChangeImagesIndexState extends HomeState{}



class GetProductsLoadingState extends HomeState {}
class GetProductsSuccessState extends HomeState {}
class GetProductsErrorState extends HomeState {
  final String error;

  GetProductsErrorState(this.error);
}


class GetFavoritesLoadingState extends HomeState {}

class GetFavoritesSuccessState extends HomeState {}

class GetFavoritesErrorState extends HomeState {
  final String error;

  GetFavoritesErrorState(this.error);
}


class ToggleFavoriteChangedState extends HomeState {}
class ToggleFavoriteErrorState extends HomeState {
  final String error;

  ToggleFavoriteErrorState(this.error);
}


class ChangeQuantityCounterState extends HomeState {}


// Add To Cart
class AddToCartLoadingState extends HomeState {}
class AddToCartSuccessState extends HomeState {}
class AddToCartErrorState extends HomeState {
  final String error;

  AddToCartErrorState(this.error);
}



class GetCartSuccessState extends HomeState {}
class RemoveCartSuccessState extends HomeState {}

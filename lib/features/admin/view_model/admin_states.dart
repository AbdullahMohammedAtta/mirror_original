abstract class AdminStates {}

class AdminInitial extends AdminStates {}

class AdminMainImagePickedState extends AdminStates {}

class AdminGalleryImagesPickedState extends AdminStates {}

class AdminRemoveIndexFromGalleryImagesListState extends AdminStates {}

class AdminAddProductLoadingState extends AdminStates {}

class AdminAddProductSuccessState extends AdminStates {}

class AdminAddProductErrorState extends AdminStates {
  final String error;

  AdminAddProductErrorState(this.error);
}


class GetProductsLoadingState extends AdminStates {}
class GetProductsSuccessState extends AdminStates {}
class GetProductsErrorState extends AdminStates {
  final String error;

  GetProductsErrorState(this.error);
}


class DeleteProductLoadingState extends AdminStates {}
class DeleteProductSuccessState extends AdminStates {}
class DeleteProductErrorState extends AdminStates {
  final String error;

  DeleteProductErrorState(this.error);
}


class GetUsersLoadingState extends AdminStates {}
class GetUsersSuccessState extends AdminStates {}
class GetUsersErrorState extends AdminStates {
  final String error;

  GetUsersErrorState(this.error);
}
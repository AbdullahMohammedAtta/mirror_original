abstract class AdminStates {}

class AdminInitial extends AdminStates {}

class AdminMainImagePickedState extends AdminStates {}

class AdminGalleryImagesPickedState extends AdminStates {}

class AdminRemoveIndexFromGalleryImagesListState extends AdminStates {}

class AdminLoadingState extends AdminStates {}

class AdminSuccessState extends AdminStates {}

class AdminErrorState extends AdminStates {
  final String error;

  AdminErrorState(this.error);
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
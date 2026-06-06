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
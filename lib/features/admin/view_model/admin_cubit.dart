import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  File? mainImage;
  List<File> galleryImages = [];

  Future<void> pickMainImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      mainImage = File(image.path);
      emit(AdminMainImagePickedState());
    }
  }





  Future<void> pickGalleryImages() async {
    final images = await ImagePicker().pickMultiImage(
      imageQuality: 85,
    );

    if (images.isNotEmpty) {
      galleryImages.addAll(
        images.map((e) => File(e.path)),
      );

      emit(AdminGalleryImagesPickedState());
    }
  }




  void removeImageFromGalleryImagesList(index)
  {
    galleryImages.removeAt(index);
    emit(AdminRemoveIndexFromGalleryImagesListState());
  }




  Future<String> uploadMainImage() async {
    if (mainImage == null) {
      throw Exception("Main image is null");
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final ref = FirebaseStorage.instance
        .ref()
        .child('products/main/$fileName');

    final uploadTask = await ref.putFile(mainImage!);

    return await uploadTask.ref.getDownloadURL();
  }



  Future<List<String>> uploadGalleryImages() {
    List<String> urls = [];

    Future<void> uploadNext(int index) {
      if (index >= galleryImages.length) {
        return Future.value();
      }

      final file = galleryImages[index];

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_$index.jpg';

      return storage
          .ref()
          .child('products/gallery_images/$fileName')
          .putFile(file)
          .then((snapshot) {
        return snapshot.ref.getDownloadURL();
      }).then((url) {
        urls.add(url);
        return uploadNext(index + 1);
      });
    }

    return uploadNext(0).then((_) => urls);
  }





  Future<void> addProduct(ProductModel product) async {
    if (mainImage == null) {
      emit(
        AdminErrorState(
          'Please select main image',
        ),
      );
      return;
    }

    emit(AdminLoadingState());

    uploadMainImage()
        .then((mainImageUrl) {
      return uploadGalleryImages().then((galleryUrls) {
        final docRef =
        firestore.collection('products').doc();

        final newProduct = ProductModel(
          id: docRef.id,
          title: product.title,
          description: product.description,
          brand: product.brand,
          category: product.category,
          price: product.price,
          oldPrice: product.oldPrice,
          discount: product.discount,
          mainImage: mainImageUrl,
          images: galleryUrls,
          rating: product.rating,
          reviewsCount: product.reviewsCount,
          stock: product.stock,
          isAvailable: product.isAvailable,
          sizes: product.sizes,
          colors: product.colors,
          isFeatured: product.isFeatured,
          isFavorite: product.isFavorite,
          soldCount: product.soldCount,
        );

        return docRef.set({
          "firebaseId": docRef.id,
          ...newProduct.toJson(),
        });
      });
    }).then((_) {
      mainImage = null;
      galleryImages.clear();

      emit(AdminSuccessState());
    }).catchError((error) {
      emit(
        AdminErrorState(
          error.toString(),
        ),
      );
    });
  }
}
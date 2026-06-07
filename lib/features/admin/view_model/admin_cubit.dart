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

  void removeImageFromGalleryImagesList(int index) {
    galleryImages.removeAt(index);
    emit(AdminRemoveIndexFromGalleryImagesListState());
  }

  Future<String> uploadMainImage() async {
    if (mainImage == null) {
      throw Exception('Please select main image');
    }

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final ref = storage
        .ref()
        .child('products/main/$fileName');

    final snapshot = await ref.putFile(mainImage!);

    return await snapshot.ref.getDownloadURL();
  }

  Future<List<String>> uploadGalleryImages() async {
    List<String> urls = [];

    for (int i = 0; i < galleryImages.length; i++) {
      final file = galleryImages[i];

      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

      final snapshot = await storage
          .ref()
          .child('products/gallery_images/$fileName')
          .putFile(file);

      final url = await snapshot.ref.getDownloadURL();

      urls.add(url);
    }

    return urls;
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      if (mainImage == null) {
        emit(
          AdminErrorState(
            'Please select main image',
          ),
        );
        return;
      }

      emit(AdminLoadingState());

      final mainImageUrl = await uploadMainImage();

      final galleryUrls = await uploadGalleryImages();

      final docRef = firestore
          .collection('products')
          .doc();

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

      await docRef.set({
        "firebaseId": docRef.id,
        ...newProduct.toJson(),
      });

      mainImage = null;
      galleryImages.clear();

      emit(AdminSuccessState());
    } catch (error) {
      emit(
        AdminErrorState(
          error.toString(),
        ),
      );
    }
  }
}
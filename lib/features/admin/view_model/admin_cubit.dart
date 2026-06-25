import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirror_original/features/admin/view_model/admin_states.dart';
import 'package:mirror_original/features/auth/model/user_model.dart';
import 'package:mirror_original/features/home/model/category_model.dart';
import 'package:mirror_original/features/home/model/product_model.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of(context);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //final FirebaseStorage storage = FirebaseStorage.instance;

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




  Future<String> uploadImageToCloudinary(File imageFile,) async {

    const cloudName = 'dp0i2qyhg';
    const uploadPreset = 'myPreset';

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ),
    );

    final response = await request.send();

    final responseData =
    await response.stream.bytesToString();

    print('Cloudinary Status: ${response.statusCode}');
    print('Cloudinary Response: $responseData');

    if (response.statusCode == 200) {
      final jsonData = json.decode(responseData);
      return jsonData['secure_url'];
    } else {
      throw Exception(responseData);
    }
  }




  Future<String> uploadMainImage() async {

    if (mainImage == null) {
      throw Exception(
        'Please select main image',
      );
    }

    return await uploadImageToCloudinary(
      mainImage!,
    );
  }





  Future<List<String>> uploadGalleryImages() async {

    List<String> urls = [];

    for (final image in galleryImages) {

      final url =
      await uploadImageToCloudinary(
        image,
      );

      urls.add(url);
    }

    return urls;
  }


  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(GetProductsLoadingState());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      products = snapshot.docs
          .map(
            (e) => ProductModel.fromJson(
          e.data(),
        ),
      )
          .toList();

      emit(GetProductsSuccessState());
    } catch (e) {
      emit(
        GetProductsErrorState(
          e.toString(),
        ),
      );
    }
  }



  Future<void> addProduct(ProductModel product) async {
    try {
      if (mainImage == null) {
        emit(
          AdminAddProductErrorState(
            'Please select main image',
          ),
        );
        return;
      }

      emit(AdminAddProductLoadingState());

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
        categoryId: product.categoryId,
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

      emit(AdminAddProductSuccessState());
    } catch (error) {
      emit(
        AdminAddProductErrorState(
          error.toString(),
        ),
      );
    }
  }




  Future<void> deleteProduct(String productId) async {
    try {
      emit(DeleteProductLoadingState());

      await firestore
          .collection('products')
          .doc(productId)
          .delete();

      products.removeWhere(
            (product) => product.id == productId,
      );

      emit(DeleteProductSuccessState());

    } catch (e) {
      emit(
        DeleteProductErrorState(
          e.toString(),
        ),
      );
    }
  }



  void changeCategory()
  {
    emit(AdminChangeCategoryState());
  }
  String? selectedCategoryId;
  List<CategoryModel> categories = [];
  Future<void> getCategories() async {
    final value = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    categories = value.docs
        .map(
          (e) => CategoryModel.fromJson(
        e.data(),
      ),
    )
        .toList();

    emit(AdminGetCategoriesSuccessState());
    print(categories.length);
  }


  List<UserModel> users = [];
  Future<void> getUsers() async {
    emit(GetUsersLoadingState());

    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();
      print("User is ${snapshot.docs.length}");
      users = snapshot.docs.map((doc) {
        return UserModel.fromJson(
          doc.data() as Map<String, dynamic>,
        );
      }).toList();

      emit(GetUsersSuccessState());
    } catch (e) {
      emit(GetUsersErrorState(e.toString()));
      print(e.toString());
    }
  }

}
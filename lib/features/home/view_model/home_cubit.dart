import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/cart/model/cart_model.dart';
import 'package:mirror_original/features/cart/view/cart_page.dart';
import 'package:mirror_original/features/home/Widgets/home_body.dart';
import 'package:mirror_original/features/home/model/category_model.dart';
import 'package:mirror_original/features/home/model/product_model.dart';
import 'package:mirror_original/features/home/view_model/home_state.dart';
import 'package:mirror_original/features/profile/view/profile_page.dart';
import 'package:mirror_original/features/search/view/search_page.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);



  List<CategoryModel> categories = [];
  int selectedCategoriesIndex = 0;

  void changeCategories(int index)
  {
    selectedCategoriesIndex = index;
    emit(ChangeCatState());
  }



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

    emit(GetCategoriesSuccessState());
    print(categories.length);
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

  int productImagesIndex = 0;
  void changeImagesIndex(index)
  {
    productImagesIndex = index;
    emit(ChangeImagesIndexState());
  }

  String selectedImage(ProductModel product) {
    return productImagesIndex == 0
        ? product.mainImage
        : product.images[productImagesIndex - 1];
  }



  List<ProductModel> products = [];

  Future<void> getProducts() async {
    getFavorites();
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


  List<ProductModel> get favoriteProducts {
    return products.where(
          (product) => favoriteIds.contains(product.id),
    ).toList();
  }

  // Future<void> addToFavorite(String productId) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('favorites')
  //       .doc(productId)
  //       .set({
  //     'productId': productId,
  //   });
  // }
  //
  //
  //
  // Future<void> removeFromFavorite(String productId) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('favorites')
  //       .doc(productId)
  //       .delete();
  // }





  Set<String> favoriteIds = {};
  Future<void> getFavorites() async {
    favoriteIds.clear(); // ⭐ Very Important
    products.clear();

    String uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();

    favoriteIds = snapshot.docs
        .map((e) => e['productId'] as String)
        .toSet();

    emit(GetFavoritesSuccessState());
  }



  Future<void> toggleFavorite(String productId) async {
    try {
      // 1. Update UI immediately (Optimistic Update)
      if (favoriteIds.contains(productId)) {
        favoriteIds.remove(productId);
      } else {
        favoriteIds.add(productId);
      }

      emit(ToggleFavoriteChangedState());

      // 2. Sync with Firebase
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final userFavRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId);

      if (favoriteIds.contains(productId)) {
        await userFavRef.set({
          'productId': productId,
        });
      } else {
        await userFavRef.delete();
      }

    } catch (e) {
      emit(ToggleFavoriteErrorState(e.toString()));
    }
  }



  // void clearFavorites() {
  //   favoriteIds.clear();
  // }


  int currentQuantity = 0;
  Future<void> increaseQuantity(String productId) async
  {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId);

    await doc.update({
      'quantity': FieldValue.increment(1),
    });

    getCart();
  }

  Future<void> decreaseQuantity(String productId,) async
  {

  if (currentQuantity <= 1) {
    removeFromCart(productId);
    return;
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('cart')
      .doc(productId)
      .update({
    'quantity': FieldValue.increment(-1),
  });

  getCart();
}





  List<CartModel> cartItems = [];
  Future<void> getCart() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();

    cartItems = snapshot.docs
        .map((e) => CartModel.fromJson(e.data()))
        .toList();

    emit(GetCartSuccessState());
  }


  Future<void> addToCart(String productId) async {
    emit(AddToCartLoadingState());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final doc = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(productId);

      final snapshot = await doc.get();

      if (snapshot.exists) {
        await doc.update({
          'quantity': FieldValue.increment(1),
        });
      } else {
        await doc.set({
          'productId': productId,
          'quantity': 1,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }

      emit(AddToCartSuccessState());
      getCart();
    } catch (e) {
      emit(AddToCartErrorState(e.toString()));
    }
  }

  Future<void> removeFromCart(String productId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId)
        .delete();

    cartItems.removeWhere((e) => e.productId == productId);

    emit(RemoveCartSuccessState());
  }

  List<ProductModel> searchProducts = [];
  void search(String text) {
    if (text.trim().isEmpty) {
      searchProducts = [];
    } else {
      final query = text.toLowerCase().trim();

      searchProducts = products.where((product) {
        return product.title.toLowerCase().contains(query) ||
            product.brand.toLowerCase().contains(query) ||
            product.categoryId.toLowerCase().contains(query);
      }).toList();
    }

    emit(SearchSuccessState());
  }
}
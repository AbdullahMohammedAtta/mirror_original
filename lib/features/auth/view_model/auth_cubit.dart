import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/auth/model/user_model.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // LOGIN
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.message ?? 'Login Error'));
      print(e.toString());
    }
  }

  // REGISTER
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {

    emit(RegisterLoadingState());

    try {

      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        name: name,
        email: email,
        password: password,
        phone: phone,
        image: '',
      );

      await fireStore
          .collection('users')
          .doc(userModel.uId)
          .set(userModel.toJson());

      emit(RegisterSuccessState());

    } catch (e) {

      emit(RegisterErrorState(e.toString()));
      print(e.toString());

    }
  }

  // LOGOUT
  Future<void> logout() async {
    await auth.signOut();
  }

  bool isVisible = false;
  void changeIcon()
  {
    isVisible = !isVisible;
    emit(ChangeIconState());
  }
}
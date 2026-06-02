import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/auth/model/user_model.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // ================= LOGIN =================

  Future<void> login({required String email, required String password,}) async
  {
    emit(LoginLoadingState());

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((onValue){

        emit(LoginSuccessState(uId: onValue.user!.uid));
        print('User ID is : ${onValue.user!.uid}');

    }).catchError((onError)
      {
        emit(LoginErrorState(onError.message ?? 'Login Error'));
      }
      );

  }

  // ================= REGISTER =================

  Future<void> register({required String name, required String email, required String password, required String phone,}) async
  {

    emit(RegisterLoadingState());

    try {

      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send Email Verification
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        image: '',
      );

      await fireStore
          .collection('users')
          .doc(userModel.uId)
          .set(userModel.toJson());

      emit(RegisterSuccessState(uId: userModel.uId));
      print('User ID is : ${userModel.uId}');
    } on FirebaseAuthException catch (e) {

      emit(
        RegisterErrorState(
          e.message ?? 'Register Error',
        ),
      );

      debugPrint(e.toString());

    } catch (e) {

      emit(
        RegisterErrorState(
          e.toString(),
        ),
      );

      debugPrint(e.toString());
    }
  }

  // ================= LOGOUT =================

  Future<void> logout() async {

    try {

      await auth.signOut();

      emit(LogoutSuccessState());

    } catch (e) {

      debugPrint(e.toString());
    }
  }

  // ================= PASSWORD VISIBILITY =================

  bool isVisible = true;

  void changeIcon() {

    isVisible = !isVisible;

    emit(ChangeIconState());
  }

  // ================= CHECK EMAIL VERIFIED =================

  bool isEmailVerified() {

    return auth.currentUser?.emailVerified ?? false;
  }

  // ================= GET CURRENT USER =================

  User? get currentUser => auth.currentUser;
}
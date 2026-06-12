abstract class AuthState {}

class AuthInitial extends AuthState {}



class LogoutSuccessState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String uId;

  LoginSuccessState({required this.uId});
}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String uId;

  RegisterSuccessState({required this.uId});
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}


class ChangeIconState extends AuthState {}



class GetUserLoadingState extends AuthState {}

class GetUserSuccessState extends AuthState {}

class GetUserErrorState extends AuthState {
  final String error;
  GetUserErrorState(this.error);
}


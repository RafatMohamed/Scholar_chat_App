import 'package:scholar_chat_proj/features/login/data/model.dart';

class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginModel loginModel;
  LoginSuccess({required this.loginModel});
}

final class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}

final class LoginChangePasswordVisibility extends LoginState {
  final bool passwordVisibility;
  LoginChangePasswordVisibility({required this.passwordVisibility});
}



import 'package:scholar_chat_proj/features/login/data/model.dart';

class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
 LoginModel loginModel;
 LoginSuccess({required this.loginModel});
}
final class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}

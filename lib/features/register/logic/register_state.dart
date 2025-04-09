import 'package:scholar_chat_proj/features/register/data/model.dart';

class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  RegisterModel registerModel;

  RegisterSuccess({required this.registerModel});
}

final class RegisterError extends RegisterState {
  String error;

  RegisterError({required this.error});
}

final class RegChangePasswordVisibility extends RegisterState {
  final bool passwordVisibility;

  RegChangePasswordVisibility({required this.passwordVisibility});
}

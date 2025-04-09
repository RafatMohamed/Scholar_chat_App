import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() :  super(LoginInitial());
   bool obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   final GlobalKey<FormState> formKey = GlobalKey();
  static LoginCubit get(context) => BlocProvider.of(context);

  void resetLoginState() {
    emit(LoginInitial());
  }
  Future<void> onRefresh() {
      emailController.clear();
      passwordController.clear();
      return Future.value();
  }

  Future<void> login({required LoginModel loginModel}) async {
    emit(LoginLoading());
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(loginModel: LoginModel(email: email, password: password)));
    } on FirebaseAuthException catch (e) {
      log(e.message ?? 'FirebaseAuth error');
      switch (e.code) {
        case 'user-not-found':
          emit(LoginError(error: "No user found for that email."));
          break;
        case 'wrong-password':
          emit(LoginError(error: "Incorrect password."));
          break;
        case 'invalid-credential':
          emit(LoginError(error: "Invalid email or password. Please check and try again."));
          break;
        case 'invalid-email':
          emit(LoginError(error: "The email address is badly formatted."));
          break;
        case 'user-disabled':
          emit(LoginError(error: "This user account has been disabled."));
          break;
        case 'too-many-requests':
          emit(LoginError(error: "Too many login attempts. Try again later."));
          break;
        default:
          emit(LoginError(error: e.message ?? "Authentication failed. Please try again later."));
      }
    } catch (e) {
      log('General error: $e');
      emit(LoginError(error: "Oops, something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
  void changePasswordVisibility() {
    obscureText = !obscureText;
    emit(LoginChangePasswordVisibility(passwordVisibility: obscureText));
  }
}



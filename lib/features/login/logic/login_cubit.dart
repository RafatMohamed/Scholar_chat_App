import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/login/data/model.dart';
import 'package:scholar_chat_proj/features/login/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static LoginCubit get(context) => BlocProvider.of(context);
  void resetLoginState() {
    emit(LoginInitial());
  }
  login({required LoginModel loginModel}) async {
    emit(LoginLoading());
    try {
      final emailAddress = emailController.text.trim();
      final password = passwordController.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(LoginSuccess(loginModel: LoginModel(email: emailAddress, password: password)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError(error: "user-not-found"));
        log('No user found for that email.');
      } else if (e.code == 'wrong-password')  {
        emit(LoginError(error: "wrong-password"));
        log('Wrong password provided for that user.');
      }
      emit(LoginError(error: "user-not-found or wrong-password"));
    } catch (e) {
      emit(LoginError(error: "OPps something went wrong${e.toString()}"));
      log(e.toString());
    }
  }
}


import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/register/data/model.dart';
import 'package:scholar_chat_proj/features/register/logic/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool obscureText = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static RegisterCubit get(context) => BlocProvider.of(context);

  register({required RegisterModel registerModel}) async {
    emit(RegisterLoading());
    try {
      final emailAddress = emailController.text.trim();
      final password = passwordController.text.trim();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(
        RegisterSuccess(
          registerModel: RegisterModel(email: emailAddress, password: password),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterError(error: "The password provided is too weak."));
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterError(error: "The account already exists for that email."),
        );
        log('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        emit(RegisterError(error: "The email address is badly formatted."));
        log('The email address is badly formatted.');
      } else if (e.code == 'operation-not-allowed') {
        emit(
          RegisterError(
            error:
                "Email/password accounts are not enabled. Please check your Firebase authentication settings.",
          ),
        );
        log('Email/password accounts are not enabled.');
      } else {
        emit(
          RegisterError(
            error: "An unknown error occurred. Please try again later.",
          ),
        );
        log('Firebase Auth error: ${e.message}');
      }
    } on SocketException catch (e) {
      emit(
        RegisterError(
          error: "No internet connection. Please check your network settings.",
        ),
      );
      log('Network error: $e');
    } catch (e) {
      emit(RegisterError(error: "Oops! Something went wrong: ${e.toString()}"));
      log('General error: $e');
    }
  }

  void changePasswordVisibility() {
    obscureText = !obscureText;
    emit(RegChangePasswordVisibility(passwordVisibility: obscureText));
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/register/data/model.dart';
import 'package:scholar_chat_proj/features/register/logic/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static RegisterCubit get(context) => BlocProvider.of(context);
  reqister({required RegisterModel registerModel }) async {
    emit(RegisterLoading());
    try {
      final emailAddress = emailController.text.trim();
      final password = passwordController.text.trim();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(RegisterSuccess(registerModel: RegisterModel(email: emailAddress, password: password)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterError(error: "The password provided is too weak."));
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterError(error: "The account already exists for that email."));
        log('The account already exists for that email.');
      }
    } catch (e) {
      emit(RegisterError(error: "OPps something went wrong${e.toString()}"));
      log(e.toString());
    }
  }
}


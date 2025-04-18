import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgetPassword_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  GlobalKey<FormState> formKey=GlobalKey();
  Future <void> resetPassword({required dynamic emailAuth}) async {
    emit(ForgetPasswordLoading());
    if (emailAuth.isEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAuth);
        emit(ForgetPasswordSuccess(message: "Password reset link sent to $emailAuth"));
      } on FirebaseAuthException catch (e) {
        emit(ForgetPasswordFailed(error: e.toString()));
      }catch(e){
        emit(ForgetPasswordFailed(error: "failed to send reset email ${e.toString()}"));
      }
    }
  }
}

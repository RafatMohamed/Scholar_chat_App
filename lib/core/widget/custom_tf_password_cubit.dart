import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/register/logic/register_cubit.dart';

import '../../features/login/logic/login_cubit.dart';
import '../../features/login/logic/login_state.dart';
import '../../features/register/logic/register_state.dart';
import 'default_text_form_field_app.dart';

Widget customTextFormPasswordLogin(context) {
  final cubit = LoginCubit.get(context);
  return   BlocBuilder<LoginCubit, LoginState>(
    builder: (context, state) {
      if (state is LoginChangePasswordVisibility) {
        cubit.obscureText = state.passwordVisibility;
      }
      return TextFormFieldApp(
        suffixIcon: IconButton(
          onPressed: () {
            cubit.changePasswordVisibility();
          },
          icon: Icon(
            color: Colors.white,
            cubit.obscureText
                ? Icons.visibility_off
                : Icons.remove_red_eye,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your password";
          } else if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        obscureText: cubit.obscureText,
        labelText: "password",
        hintText: 'please enter your password',
        onSubmitted: (value) {
          cubit.passwordController.text = value;
        },
        controller: cubit.passwordController,
      );
    },
  );
}
Widget customTextFormPasswordRegister(context) {
  final cubit = RegisterCubit.get(context);
  return   BlocBuilder<RegisterCubit, RegisterState>(
    builder: (context, state) {
      if (state is RegChangePasswordVisibility) {
        cubit.obscureText = state.passwordVisibility;
      }
      return TextFormFieldApp(
        suffixIcon: IconButton(
          onPressed: () {
            cubit.changePasswordVisibility();
          },
          icon: Icon(
            color: Colors.white,
            cubit.obscureText
                ? Icons.visibility_off
                : Icons.remove_red_eye,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your password";
          } else if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        obscureText: cubit.obscureText,
        labelText: "password",
        hintText: 'please enter your password',
        onSubmitted: (value) {
          cubit.passwordController.text = value;
        },
        controller: cubit.passwordController,
      );
    },
  );
}
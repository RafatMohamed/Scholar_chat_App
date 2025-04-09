import 'package:flutter/material.dart';

import '../../features/login/logic/login_cubit.dart';
import '../../features/register/logic/register_cubit.dart';
import 'default_text_form_field_app.dart';

Widget customTextFormEmailLogin(context) {
  final cubit = LoginCubit.get(context);
  return TextFormFieldApp(
    suffixIcon: const Icon(
      Icons.email,
      color: Colors.white,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your email";
      } else if (!value.contains("@")) {
        return "Please enter a valid email";
      }
      return null;
    },
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    labelText: "Email",
    hintText: 'Please enter your email',
    onSubmitted: (value) {
      cubit.emailController.text = value;
    },
    controller: cubit.emailController,
  );
}
Widget customTextFormEmailRegister(context) {
  final cubit = RegisterCubit.get(context);
  return TextFormFieldApp(
    suffixIcon: const Icon(
      Icons.email,
      color: Colors.white,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your email";
      } else if (!value.contains("@")) {
        return "Please enter a valid email";
      }
      return null;
    },
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    labelText: "Email",
    hintText: 'Please enter your email',
    onSubmitted: (value) {
      cubit.emailController.text = value;
    },
    controller: cubit.emailController,
  );
}
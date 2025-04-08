import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';
import 'package:scholar_chat_proj/core/helper/navigator_app.dart';
import 'package:scholar_chat_proj/features/chat/views/chat_view.dart';
import 'package:scholar_chat_proj/features/login/data/model.dart';
import 'package:scholar_chat_proj/features/login/logic/login_cubit.dart';
import 'package:scholar_chat_proj/features/login/logic/login_state.dart';
import 'package:scholar_chat_proj/features/register/views/register_view.dart';

import '../../../core/helper/notify_app.dart';
import '../../../core/widget/default_material_button.dart';
import '../../../core/widget/default_text_butt.dart';
import '../../../core/widget/default_text_form_field_app.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final fixedSizeHeight = MediaQuery
        .of(context)
        .size
        .height;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(
          builder: (context) {
            final cubit = LoginCubit.get(context);
            return RefreshIndicator(
              onRefresh: () {
                cubit.emailController.clear();
                cubit.passwordController.clear();
                return Future.value();
              },
              child: Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/scholar.png",
                                fit: BoxFit.fill,
                              ),
                              Text(
                                "Scholar Chat",
                                style:
                                TextStyle(
                                  fontFamily: AppConstant.fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: fixedSizeHeight * 0.12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormFieldApp(
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
                              ),
                              TextFormFieldApp(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter your password";
                                  } else if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                labelText: "password",
                                hintText: 'please enter your password',
                                onSubmitted: (value) {
                                  cubit.passwordController.text = value;
                                },
                                controller: cubit.passwordController,
                              ),
                            ],
                          ),
                          SizedBox(height: fixedSizeHeight * 0.03,),
                          Column(
                            children: [
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if(state is LoginSuccess){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      NotifyApp.snackBar(widget:  Text("Sign up successfully ${cubit.emailController.text}",style: const TextStyle(color: AppConstant.primaryColor),)),
                                    );
                                    NavigatorApp.pushPage(context,  ChatView(email: cubit.emailController.text));
                                  }
                                  if(state is LoginError){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      NotifyApp.snackBar( widget:  Text(state.error,style: const TextStyle(color: AppConstant.primaryColor),)),
                                      snackBarAnimationStyle: AnimationStyle(curve: FlippedCurve(Curves.bounceIn),reverseCurve: Curves.bounceInOut),
                                    );
                                    cubit.resetLoginState();
                                  }
                                },
                                builder: (context, state) {
                                  if(state is LoginLoading){
                                    return  NotifyApp.circularProgress();
                                  }
                                  return DefaultMaterialButton(
                                    onPressed: () {
                                      if(
                                      cubit.emailController.text.isNotEmpty
                                          && cubit.passwordController.text.isNotEmpty){
                                        cubit.login(
                                            loginModel: LoginModel(
                                                email: cubit.emailController.text,
                                                password: cubit.passwordController.text
                                            )
                                        );
                                      }
                                    },
                                    text: "Sign In",
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DefaultTextButton(
                                    onPressed: () {
                                      NavigatorApp.pushPage(
                                          context, RegisterView());
                                    },
                                    text: "Sign Up",
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';
import 'package:scholar_chat_proj/core/helper/navigator_app.dart';
import 'package:scholar_chat_proj/features/chat/views/chat_view.dart';
import 'package:scholar_chat_proj/features/forget_password/model/forgetPassword_cubit.dart';
import 'package:scholar_chat_proj/features/forget_password/model/forgetPassword_state.dart';
import 'package:scholar_chat_proj/features/forget_password/model/forgetpassword_cubit.dart';
import 'package:scholar_chat_proj/features/login/logic/login_cubit.dart';
import 'package:scholar_chat_proj/features/login/logic/login_state.dart';
import 'package:scholar_chat_proj/features/register/views/register_view.dart';
import '../../../core/helper/notify_app.dart';
import '../../../core/widget/custom_tf_email.dart';
import '../../../core/widget/custom_tf_password_cubit.dart';
import '../../../core/widget/custom_logo_text.dart';
import '../../../core/widget/default_material_button.dart';
import '../../../core/widget/default_text_butt.dart';
import '../../forget_password/views/forget_password_view.dart';
import '../data/model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final fixedSizeHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(
        builder: (context) {
          final cubit = LoginCubit.get(context);
          return RefreshIndicator(
            onRefresh: () {
              return cubit.onRefresh();
            },
            child: Scaffold(
              body: Form(
                key: cubit.formKey,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.017,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customLogoText(),
                          SizedBox(height: fixedSizeHeight * 0.12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign In",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              customTextFormEmailLogin(context),
                              const SizedBox(height: 10),
                              customTextFormPasswordLogin(context),
                             Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    textStyle: const TextStyle(
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      leadingDistribution: TextLeadingDistribution.even,
                                      textBaseline: TextBaseline.alphabetic,
                                    ),
                                  ),
                                  onPressed: () {
                                    NavigatorApp.pushPage(
                                      context,
                                      ForgetPasswordView(
                                        emailAuth: cubit.emailController,
                                      ),
                                    );
                                  },
                                  child: const Text("Forget Password"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: fixedSizeHeight * 0.03),
                          Column(
                            children: [
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      NotifyApp.snackBar(
                                        widget: Text(
                                          "Sign up successfully ${cubit.emailController.text}",
                                          style: const TextStyle(
                                            color: AppConstant.primaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                    NavigatorApp.pushPage(
                                      context,
                                      ChatView(
                                        email: cubit.emailController.text,
                                      ),
                                    );
                                  }
                                  if (state is LoginError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      NotifyApp.snackBar(
                                        widget: Text(
                                          state.error,
                                          style: const TextStyle(
                                            color: AppConstant.primaryColor,
                                          ),
                                        ),
                                      ),
                                      snackBarAnimationStyle: AnimationStyle(
                                        curve: const FlippedCurve(
                                          Curves.bounceIn,
                                        ),
                                        reverseCurve: Curves.bounceInOut,
                                      ),
                                    );
                                    // cubit.resetLoginState();
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return NotifyApp.circularProgress();
                                  }
                                  return DefaultMaterialButton(
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.login(
                                          loginModel: LoginModel(
                                            email: cubit.emailController.text,
                                            password:
                                                cubit.passwordController.text,
                                          ),
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
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DefaultTextButton(
                                    onPressed: () {
                                      NavigatorApp.pushPage(
                                        context,
                                        const RegisterView(),
                                      );
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
            ),
          );
        },
      ),
    );
  }
}

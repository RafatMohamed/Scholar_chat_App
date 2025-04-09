import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/helper/notify_app.dart';
import 'package:scholar_chat_proj/core/widget/custom_tf_email.dart';
import 'package:scholar_chat_proj/features/register/data/model.dart';
import 'package:scholar_chat_proj/features/register/logic/register_cubit.dart';
import 'package:scholar_chat_proj/features/register/logic/register_state.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/helper/navigator_app.dart';
import '../../../core/widget/custom_tf_password_cubit.dart';
import '../../../core/widget/custom_logo_text.dart';
import '../../../core/widget/default_material_button.dart';
import '../../../core/widget/default_text_butt.dart';
import '../../chat/views/chat_view.dart';
import '../../login/views/login_view.dart';
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final fixedSizeHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          final cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customLogoText(),
                        SizedBox(height: fixedSizeHeight * 0.12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              "Sign UP",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            customTextFormEmailRegister(context),
                            customTextFormPasswordRegister(context),
                          ],
                        ),
                        SizedBox(height: fixedSizeHeight * 0.03),
                        Column(
                          children: [
                            BlocConsumer<RegisterCubit, RegisterState>(
                              listener: (context, state) {
                              if(state is RegisterSuccess){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    NotifyApp.snackBar(widget:  Text("Sign up successfully ${cubit.emailController.text}, you can login now",style: TextStyle(color: AppConstant.primaryColor),)),
                                    );
                                NavigatorApp.pushPage(context, ChatView(email: cubit.emailController.text));}
                              if(state is RegisterError){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    NotifyApp.snackBar( widget:  Text(state.error,style: TextStyle(color: AppConstant.primaryColor),),),
                                  snackBarAnimationStyle: AnimationStyle(curve: FlippedCurve(Curves.bounceIn),reverseCurve: Curves.bounceInOut,),
                                );
                              }
                              },
                              builder: (context, state) {
                                if (state is RegisterLoading) {
                                return NotifyApp.circularProgress();
                                }
                                return DefaultMaterialButton(
                                  onPressed: () {
                                  if(cubit.formKey.currentState!.validate()){
                                    cubit.register(
                                      registerModel: RegisterModel(
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text
                                      )
                                    );
                                  }
                                  else{
                                    return null;
                                  }
                                  },
                                  text: "Sign up",
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Do you have an account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                DefaultTextButton(
                                  onPressed: () {
                                    NavigatorApp.pushPage(
                                      context,
                                    const   LoginView(),
                                    );
                                  },
                                  text: "Sign In",
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
        },
      ),
    );
  }
}

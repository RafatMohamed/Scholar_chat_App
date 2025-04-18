import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/helper/notify_app.dart';
import '../../../core/widget/default_text_form_field_app.dart';
import '../model/forgetPassword_cubit.dart';
import '../model/forgetPassword_state.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key, required this.emailAuth});
  final TextEditingController emailAuth;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child:  Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: context.read<ForgetPasswordCubit>().formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).height * 0.017,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormFieldApp(
                          suffixIcon: const Icon(Icons.email, color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your valid email";
                            } else if (!value.contains("@")) {
                              return "Please enter a valid email";
                            }else if (value!=emailAuth.text) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Email",
                          hintText: 'Please enter your email',
                          onSubmitted: (value) {
                            emailAuth.text=value;
                          },
                          controller: emailAuth,
                        ),
                        const SizedBox(height: 50,),
                        BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                          listener: (context, state) {
                            if (state is ForgetPasswordFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                NotifyApp.snackBar(
                                  widget: Text(
                                    state.error,
                                    style: const TextStyle(
                                      color: AppConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is ForgetPasswordSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                NotifyApp.snackBar(
                                  widget: Text(
                                    state.message,
                                    style: const TextStyle(
                                      color: AppConstant.primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if(state is ForgetPasswordLoading){
                              return NotifyApp.circularProgress();
                            }
                            return TextButton(
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
                                final cubit = context.read<ForgetPasswordCubit>();
                                if(cubit.formKey.currentState!.validate()){
                                  cubit.formKey.currentState!.save();
                                  cubit.resetPassword(emailAuth: emailAuth.text);
                                }

                              },
                              child: const Text("Forget Password"),
                            );
                          },
                        ),
                      ],
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

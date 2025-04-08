import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/helper/notify_app.dart';
import 'package:scholar_chat_proj/features/register/data/model.dart';
import 'package:scholar_chat_proj/features/register/logic/register_cubit.dart';
import 'package:scholar_chat_proj/features/register/logic/register_state.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/helper/navigator_app.dart';
import '../../../core/widget/default_material_button.dart';
import '../../../core/widget/default_text_butt.dart';
import '../../../core/widget/default_text_form_field_app.dart';
import '../../login/views/login_view.dart';

// class RegisterView extends StatelessWidget {
//    RegisterView({super.key});
//   String? emailer;
//   String? passworder;
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     // final fixedSizeWidth = MediaQuery.of(context).size.width;
//     final fixedSizeHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/scholar.png",
//                       fit: BoxFit.fill,
//                     ),
//                     Text(
//                       "Scholar Chat",
//                       style:
//                       TextStyle(
//                         fontFamily: AppConstant.fontFamily,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: fixedSizeHeight*0.12,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 10,
//                   children: [
//                     Text(
//                       "Sign UP",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     TextFormFieldApp(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your email";
//                         }else if (!value.contains("@")) {
//                           return "Please enter a valid email";
//                         }
//                         return null;
//                       },
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.emailAddress,
//                       labelText: "Email",
//                       hintText: 'Please enter your email',
//                       onChange: (email) {
//                         emailer=email;
//                         print(emailer);
//
//                       },
//                       // controller: emailController,
//                     ),
//                     TextFormFieldApp(
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return "Please enter your password";
//                         }else if (value.length < 6) {
//                           return "Password must be at least 6 characters";
//                         }
//                         return null;
//                       },
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.visiblePassword,
//                       labelText: "password",
//                       hintText: 'please enter your password',
//                       onChange: (pass ){
//                         passworder=pass;
//                         print(passworder);
//                       },
//                       // controller: passwordController,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: fixedSizeHeight*0.03,),
//                 Column(
//                   children: [
//                     DefaultMaterialButton(
//                       onPressed:() async {
//                         try {
//                           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//                             email: emailer!,
//                             password: passworder!,
//                           );
//                         }  catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//                           print('💥 Other Exception: $e');
//                         }
//                         NavigatorApp.pushPage( context, const LoginView());
//                       } ,
//                       text: "Sign up",
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Do you have an account?",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         DefaultTextButton(
//                           onPressed: () {
//                             NavigatorApp.pushPage(context, const LoginView());
//                           },
//                           text: "Sign In",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
                            style: TextStyle(
                              fontFamily: AppConstant.fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
                          TextFormFieldApp(
                            onSubmitted: (p0) {
                              cubit.emailController.text = p0;
                            },
                            controller: cubit.emailController,
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
                          ),
                          TextFormFieldApp(
                            controller: cubit.passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: "Password",
                            hintText: 'Please enter your password',
                            onSubmitted: (String value) {
                              cubit.passwordController.text = value;
                            },
                          ),
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
                              NavigatorApp.pushPage(context, const LoginView());
                            }
                            if(state is RegisterError){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  NotifyApp.snackBar( widget:  Text(state.error,style: TextStyle(color: AppConstant.primaryColor),)),
                                snackBarAnimationStyle: AnimationStyle(curve: FlippedCurve(Curves.bounceIn),reverseCurve: Curves.bounceInOut),
                              );
                            }
                            },
                            builder: (context, state) {
                              if (state is RegisterLoading) {
                              return NotifyApp.circularProgress();
                              }
                              return DefaultMaterialButton(
                                onPressed: () {
                                if(
                                cubit.emailController.text.isNotEmpty
                                    && cubit.passwordController.text.isNotEmpty){
                                  cubit.reqister(
                                    registerModel: RegisterModel(
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text
                                    )
                                  );
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
                                    const LoginView(),
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
          );
        },
      ),
    );
  }
}

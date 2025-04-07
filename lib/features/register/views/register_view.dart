import 'package:flutter/material.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/helper/Navigator_app.dart';
import '../../../core/widget/default_material_button.dart';
import '../../../core/widget/default_text_butt.dart';
import '../../../core/widget/default_text_form_field_app.dart';
import '../../login/views/login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final flixedSizeWidth = MediaQuery.of(context).size.width;
    final flixedSizeHeight = MediaQuery.of(context).size.height;
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
                      style:
                      TextStyle(
                        fontFamily: AppConstant.fontFamily,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: flixedSizeHeight*0.12,),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }else if (!value.contains("@")) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      hintText: 'Please enter your email',
                      onFieldSubmitted: (value) {
                      },
                      controller: emailController,
                    ),
                    TextFormFieldApp(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your password";
                        }else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: "password",
                      hintText: 'please enter your password',
                      onFieldSubmitted: (value ){
                      },
                      controller: passwordController,
                    ),
                  ],
                ),
                SizedBox(height: flixedSizeHeight*0.03,),
                Column(
                  children: [
                    DefaultMaterialButton(
                      onPressed:() {
                        NavigatorApp.pushPage(context, const LoginView());
                      } ,
                      text: "Sign up",
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
                            NavigatorApp.pushPage(context, const LoginView());
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
  }
}

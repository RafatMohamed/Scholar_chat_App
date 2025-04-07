import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';

import 'features/login/views/login_view.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstant.appName,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: AppConstant.primaryColor,
      ),
      home: const LoginView(),
    );
  }
}


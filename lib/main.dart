import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';

import 'features/login/views/login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Make sure this file is set up correctly
  );
  runApp(const ChatApp());
}


class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstant.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: AppConstant.primaryColor,
        ),
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


import 'package:flutter/material.dart';

abstract class NavigatorApp {
  static void pushPage(context, Widget pageRoute) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return pageRoute;
      },
    ),
  );
}

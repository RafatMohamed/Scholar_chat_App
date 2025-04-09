import 'package:flutter/cupertino.dart';
import '../constants/app_constant.dart';

Widget customLogoText() {
  return Column(
    children: [
      Image.asset(AppConstant.kLogo, fit: BoxFit.fill),
      Text(
        AppConstant.appName,
        style: TextStyle(
          fontFamily: AppConstant.fontFamily,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

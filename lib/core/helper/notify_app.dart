import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/constants/app_constant.dart';

abstract class NotifyApp {
  static SnackBar snackBar({required Widget widget}) => SnackBar(
    dismissDirection: DismissDirection.startToEnd,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    shape: BeveledRectangleBorder(
      side: const BorderSide(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 2),
    backgroundColor: Colors.white,
    content: widget,
  );

  static Future<T?> showErrorDialog<T>({
    required BuildContext context,
    required String message,
  }) {
    return showDialog<T>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"),
              ),
            ],
          ),
    );
  }

  static Widget circularProgress() {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: AppConstant.primaryColor,
      ),
    );
  }
}

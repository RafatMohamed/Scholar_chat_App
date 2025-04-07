import 'package:flutter/material.dart';

class DefaultMaterialButton extends StatelessWidget {
  const DefaultMaterialButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
  return  MaterialButton(
    height: 50,
    minWidth: double.infinity,
    onPressed: onPressed,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
     text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  }

}
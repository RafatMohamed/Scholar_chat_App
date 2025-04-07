import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget{
  const DefaultTextButton({super.key, required this.text, required this.onPressed});
 final String text;
 final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return  TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
    );
  }
}
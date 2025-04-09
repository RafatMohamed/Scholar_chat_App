import 'package:flutter/material.dart';

class TextFormFieldApp extends StatelessWidget {
  const TextFormFieldApp({
    super.key,
    this.maxLine = 1,
    required this.labelText,
    this.labelFontWeight = FontWeight.normal,
    this.labelFontSize = 19,
    this.labelColor = Colors.white,
    this.labelFontStyle = FontStyle.normal,
    this.labelTextAlign = TextAlign.start,
    required this.hintText,
    this.hintFontWeight = FontWeight.w200,
    this.hintFontSize = 14,
    this.hintColor = Colors.white,
    this.hintFontStyle = FontStyle.normal,
    this.hintTextAlign = TextAlign.start,
    this.radius = 10,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.borderDecorationColor = Colors.green,
    this.validator,
    required this.onSubmitted,
    required this.controller,
    this.obscureText=false,
    this.suffixIcon,
  });
 final bool obscureText;
  final int maxLine;
  final Color borderDecorationColor;
  final String hintText;
  final FontWeight hintFontWeight;
  final double hintFontSize;
  final Color hintColor;
  final FontStyle? hintFontStyle;
  final TextAlign? hintTextAlign;
  final String labelText;
  final FontWeight labelFontWeight;
  final double labelFontSize;
  final Color labelColor;
  final FontStyle? labelFontStyle;
  final TextAlign? labelTextAlign;
  final double radius;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: TextFormField(
        enableSuggestions: true,
        validator: validator,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
            fontStyle: labelFontStyle,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: hintFontSize,
            fontWeight: hintFontWeight,
            fontStyle: hintFontStyle,
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLine,
        textInputAction: textInputAction,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: labelColor,
          fontSize: labelFontSize,
          fontWeight: labelFontWeight,
          fontStyle: labelFontStyle,
        ),
      ),
    );
  }
}

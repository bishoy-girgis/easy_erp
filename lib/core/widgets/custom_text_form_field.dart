import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Function()? suffixPressed;
  final Function()? prefixPressed;
  final bool isSecure;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool isClickable = true;
  final Color backgroundOfTextFeild;
  final Color notFocusedBorderColor;
  final Color focusedBorderColor;
  final int? maxLines;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.labelText,
    this.prefixPressed,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.prefixIconColor,
    this.validator,
    this.suffixIcon,
    this.suffixColor,
    this.suffixPressed,
    this.isSecure = false,
    this.onSubmit,
    this.maxLines = 1,
    this.focusNode,
    this.onChange,
    this.onTap,
    this.backgroundOfTextFeild = Colors.transparent,
    this.notFocusedBorderColor = Colors.transparent,
    this.focusedBorderColor = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: isSecure,
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        focusNode: focusNode,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelStyle: TextStyle(
            color: focusedBorderColor,
            fontWeight: FontWeight.bold,
            // fontSize: 16,
          ),
          filled: true,
          fillColor: backgroundOfTextFeild,
          border: const OutlineInputBorder(
              // borderSide: BorderSide(width: 3, color: Colors.yellowAccent),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: notFocusedBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            // fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon == null
              ? null
              : IconButton(
                  onPressed: prefixPressed,
                  icon: Icon(
                    prefixIcon,
                    color: prefixIconColor,
                  ),
                ),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                    color: suffixColor,
                  ),
                ),
        ),
        keyboardType: keyboardType,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        enabled: isClickable,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../helper/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final Color backgroundColor;
  final Color titleColor;
  final Widget title;
  final Function()? onPressed;

  const CustomElevatedButton(
      {super.key,
      this.width,
      this.backgroundColor = Colors.blueGrey,
      this.titleColor = AppColors.whiteColor,
      required this.title,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            animationDuration: Duration(seconds: 1),
            shadowColor: Colors.black,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: title,
        ));
  }
}

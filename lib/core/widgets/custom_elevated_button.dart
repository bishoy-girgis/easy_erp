import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helper/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final Color backgroundColor;
  final Widget title;
  final Function() onPressed;
  final bool hasBorder;
  final double borderWidth;
  final Color borderColor;
  const CustomElevatedButton({
    super.key,
    this.width,
    this.backgroundColor = AppColors.primaryColorBlue,
    required this.title,
    required this.onPressed,
    this.hasBorder = false,
    this.borderWidth = 1.0,
    this.borderColor = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            animationDuration: const Duration(seconds: 1),
            shadowColor: Colors.white,
            backgroundColor: backgroundColor,
            side: hasBorder
                ? BorderSide(
                    width: borderWidth.w,
                    color: borderColor,
                  )
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: title,
        ));
  }
}

import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:flutter/material.dart';

import '../helper/app_colors.dart';
import '../helper/global_methods.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final Color backgroundColor;
  final Color titleColor;
  final String title;
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
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: titleColor),
          )),
    );
  }
}

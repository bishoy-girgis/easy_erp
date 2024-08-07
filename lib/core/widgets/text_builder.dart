import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_colors.dart';
import '../helper/global_methods.dart';

class TextBuilder extends StatelessWidget {
  final String text;
  final bool isHeader;
  final int? maxLines;
  final Color? color;
  final bool isCanceled;
  final bool isOverflow;
  final double? fontSize;
  final TextAlign? textAlign;

  const TextBuilder(
    this.text, {
    super.key,
    this.maxLines = 1,
    this.textAlign,
    this.isHeader = true,
    this.isOverflow = false,
    this.isCanceled = false,
    this.color = Colors.black,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Cairo',
        color: color,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: isCanceled
            ? 15.sp
            : GlobalMethods.isLandscape(context)
                ? 5.sp
                : fontSize?.sp,
        decoration:
            isCanceled ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final double contentSize;

  const CustomText({
    Key? key,
    required this.icon,
    this.iconColor = AppColors.primaryColorBlue,
    this.iconSize = 20,
    required this.text,
    this.contentSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(227, 227, 227, 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center, // Center the text content
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo",
                fontSize:  GlobalMethods.isLandscape(context)
                    ? 7.sp
                    : contentSize.sp,
              ),
            ),
          ),
          const SizedBox(width: 6), // Adjust the spacing between icon and text
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}

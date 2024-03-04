import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        fontSize: isCanceled ? 15.sp : fontSize?.sp,
        decoration:
            isCanceled ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}

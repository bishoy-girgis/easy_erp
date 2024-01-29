import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_builder.dart';

class RotatedTextWidget extends StatelessWidget {
  const RotatedTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(color: Colors.red.shade900, width: 3.w)),
          color: Colors.redAccent.withOpacity(0.20.sp),
        ),
        child: TextBuilder(
          "on sale".toUpperCase(),
          color: Colors.red.shade900,
        ),
      ),
    );
  }
}

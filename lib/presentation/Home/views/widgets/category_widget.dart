import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categoryName,
    this.icon,
    this.onTap,
  });
  final IconData? icon;
  final String categoryName;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.whiteColor,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 35.spMax,
                    color: Colors.blueGrey,
                  ),
                  const Spacer(),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextBuilder(
                    categoryName,
                    isHeader: true,
                    color: AppColors.blackColor,
                    // fontSize: ,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

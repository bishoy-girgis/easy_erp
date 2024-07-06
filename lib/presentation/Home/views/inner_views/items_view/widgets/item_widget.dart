import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helper/app_images.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/helper/utils.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    var size = Utils(context: context).screenSize;
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      padding: EdgeInsets.all(5.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColorBlue.withOpacity(0.83),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
      child: Row(children: [
        Expanded(
          flex:  3,
          child: Card(
            color: AppColors.whiteColor,
            child: Image.asset(
              AppImages.logo,
              width: size.width * .2,
              height: size.width * .15,
            ),
          ),
        ),
        const GapW(w: 2),
        Expanded(
          flex: GlobalMethods.isLandscape(context) ? 5 : 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBuilder(
                item.itmname ?? item.itmename ?? "none",
                color: AppColors.whiteColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextBuilder(
                    item.itmcode ?? "00",
                    color: AppColors.whiteColor,
                  ),
                  const GapW(w: 1),
                  const Icon(
                    Icons.perm_device_information_rounded,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBuilder(
                    item.salesprice != null ? item.salesprice.toString() : "00",
                    color: Colors.white,
                  ),
                  TextBuilder(
                    item.unitname ?? "none",
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );

  }
}

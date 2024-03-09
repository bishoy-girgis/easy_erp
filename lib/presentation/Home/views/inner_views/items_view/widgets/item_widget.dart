import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_images.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColorBlue.withOpacity(0.83),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Card(
            color: AppColors.whiteColor,
            child: Image.asset(
              AppImages.logo,
              width: size.width * .25,
              height: size.width * .25,
            ),
          ),
        ),
        const GapW(w: 2),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBuilder(
                item.itmname ?? item.itmename ?? "none",
                color: AppColors.whiteColor,
                fontSize: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextBuilder(
                    item.itmcode ?? "00",
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                  GapW(w: 1),
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

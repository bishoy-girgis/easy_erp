import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReturnWidget extends StatelessWidget {
  const ReturnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColorBlue.withOpacity(0.75),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
// invDate
            child: TextBuilder(
              "03/03/2024",
              textAlign: TextAlign.center,
              fontSize: 18,
              color: AppColors.whiteColor,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 25.sp,
                    ),
                    const GapW(w: 5),
// invNo
                    TextBuilder(
                      "110133",
                      fontSize: 20,
                    ),
                  ],
                ),
                const Divider(),
// custInvName
                TextBuilder(
                  "bishoy",
                  fontSize: 20,
                ),
                const GapH(h: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.total_icludes_tax,
                          textAlign: TextAlign.center,
                          fontSize: 14,
                        ),
// finalValue
                        TextBuilder(
                          "350",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.tax_amount,
                          textAlign: TextAlign.center,
                          fontSize: 14,
                        ),
// taxAdd
                        TextBuilder("60"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}

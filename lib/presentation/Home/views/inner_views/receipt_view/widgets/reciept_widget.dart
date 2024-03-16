import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Recieptwidget extends StatelessWidget {
  const Recieptwidget({super.key});
  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

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
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 49, 101, 128),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: TextBuilder(
              formatDate("2023-11-19T00:00:00"),
              textAlign: TextAlign.center,
              fontSize: 15,
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
                    ImageIcon(
                      const AssetImage("assets/images/product-returnn.png"),
                      size: 20.sp,
                    ),
                    const GapW(w: 5),
                    const TextBuilder(
                      "110335",
                      fontSize: 17,
                    ),
                  ],
                ),
                const Divider(),
                const TextBuilder(
                  "Bishoyy",
                  fontSize: 17,
                ),
                const GapH(h: 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.total_icludes_tax,
                          textAlign: TextAlign.center,
                          fontSize: 13,
                        ),
                        const TextBuilder(
                          "2005",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.tax_amount,
                          textAlign: TextAlign.center,
                          fontSize: 13,
                        ),
                        const TextBuilder("50"),
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
  }
}

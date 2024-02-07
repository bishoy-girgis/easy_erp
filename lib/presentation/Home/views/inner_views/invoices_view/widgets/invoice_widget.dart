import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/models/invoice_model/invoice_model.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.e,
  });
  final BillModel e;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalMethods.goRouterNavigateTO(
          context: context,
          router: AppRouters.kCreateInvoice,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        // height: size.height * .13.h,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // width: size.height * 0.11,
                // margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBuilder(
                      e.name,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      isHeader: true,
                      maxLines: 2,
                    ),
                    const GapH(h: 5),
                    const TextBuilder(
                      "6 month ago",
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      isHeader: true,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 5.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.outlined_flag_rounded,
                        ),
                        TextBuilder(
                          "123456789",
                          isHeader: true,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                    TextBuilder(
                      e.customer,
                      color: AppColors.blackColor,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextBuilder(
                              "Total",
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              isHeader: true,
                            ),
                            TextBuilder("1750.5"),
                          ],
                        ),
                        Column(
                          children: [
                            TextBuilder(
                              "Tax",
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              isHeader: true,
                            ),
                            TextBuilder("1750.5"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

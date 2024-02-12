import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/app_routing.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CustomElevatedButton(
              backgroundColor: Colors.white,
              borderColor: Colors.blueGrey,
              hasBorder: true,
              borderWidth: 2,
              title: TextBuilder(
                AppLocalizations.of(context)!.select_items,
                isHeader: true,
                color: Colors.black,
              ),
              onPressed: () {
                GlobalMethods.goRouterNavigateTO(
                    context: context, router: AppRouters.kAddItemsIntoInvoice);
              },
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.total_icludes_tax,
              color: Colors.black,
            ),
            const GapH(h: 1),
            const TextBuilder(
              "00.00",
              fontSize: 40,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    TextBuilder(
                      AppLocalizations.of(context)!.amount_before_tax,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    const TextBuilder(
                      "00.00",
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextBuilder(
                      AppLocalizations.of(context)!.tax_amount,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      "00.00",
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

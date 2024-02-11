import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/app_routing.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';

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
              title: const TextBuilder(
                "Sellect Items",
                isHeader: true,
                color: Colors.black,
              ),
              onPressed: () {
                GlobalMethods.goRouterNavigateTO(
                    context: context, router: AppRouters.kAddItemsIntoInvoice);
              },
            ),
            GapH(h: 1),
            TextBuilder(
              "Total includes tax",
              color: Colors.black,
            ),
            GapH(h: 1),
            TextBuilder(
              "87777.85",
              fontSize: 40,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    TextBuilder(
                      "Amount before tax",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      "10.5",
                      color: Colors.black,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextBuilder(
                      "Tax amount",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      "10.5",
                      color: Colors.black,
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

import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/app_routing.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/helper/locator.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PricingSection extends StatelessWidget {
  PricingSection({
    super.key,
    required this.items,
  });
  final List<ItemModel> items;
  late double totalAmount;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<AddItemCubit, AddItemState>(
          builder: (context, state) {
            for (int i = 0; i < items.length; i++) {
              totalAmount += items[i].salesprice!;
            }
            return Column(
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
                        context: context,
                        router: AppRouters.kAddItemsIntoInvoice);
                  },
                ),
                const GapH(h: 1),
                TextBuilder(
                  AppLocalizations.of(context)!.total_icludes_tax,
                  color: Colors.black,
                ),
                const GapH(h: 1),
                getIt.get<AddItemCubit>().addedItems.isEmpty
                    ? TextBuilder(
                        '00.00',
                        fontSize: 40,
                        color: Colors.black,
                      )
                    : TextBuilder(
                        totalAmount.toString(),
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
            );
          },
        ),
      ),
    );
  }
}

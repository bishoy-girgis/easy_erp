import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/invoice_cubit/cubit/invoice_cubit.dart';
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
  double totalAmount = 0.0;

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
              totalAmount += (items[i].salesprice! * items[i].quantity);
            }
            double amountBeforeTex = totalAmount -
                ((AppConstants.vat * totalAmount) / (100 + AppConstants.vat));
            double taxAmount =
                ((AppConstants.vat * totalAmount) / (100 + AppConstants.vat));
            SharedPref.set(key: 'totalAmount', value: totalAmount);
            SharedPref.set(key: 'amountBeforeTex', value: amountBeforeTex);
            SharedPref.set(key: 'taxAmount', value: taxAmount);

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
                        totalAmount.toString(),
                        fontSize: 40,
                      )
                    : TextBuilder(
                        totalAmount.toString(),
                        fontSize: 40,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.amount_before_tax,
                          fontSize: 16,
                        ),
                        TextBuilder(
                          amountBeforeTex.toStringAsFixed(2),
                          maxLines: 2,
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
                          taxAmount.toStringAsFixed(2),
                          maxLines: 2,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: CustomTextFormField(labelText: "Price"),
                    ),
                    Flexible(
                        child: DropdownButton<String>(
                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    )),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

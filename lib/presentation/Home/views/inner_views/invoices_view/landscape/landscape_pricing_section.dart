// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/payment_type_model/pay_ment_type_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/locator.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../cubits/addItem_cubit/add_item_cubit.dart';
import '../../../../../cubits/payment_type_cubit/payment_type_cubit.dart';


class LandScapePricingSection extends StatelessWidget {
  LandScapePricingSection({
    super.key,
    required this.items,
  });

  final List<ItemModel> items;

  double totalAmount = 0.0;

  double taxAmount = 0.0;

  double amountBeforeTex = 0.0;

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
            if (AppConstants.vatType == 2) {
              for (int i = 0; i < items.length; i++) {
                totalAmount +=
                    (items[i].salesprice! * items[i].quantity);
              }
              taxAmount =
                  ((AppConstants.vat * totalAmount) / (100 + AppConstants.vat));
              amountBeforeTex = totalAmount - taxAmount;
            }
            if (AppConstants.vatType == 1) {
              for (int i = 0; i < items.length; i++) {
                amountBeforeTex +=
                    (items[i].salesprice! * items[i].quantity);
              }
              taxAmount = amountBeforeTex * (AppConstants.vat / 100);
              totalAmount = amountBeforeTex + taxAmount;
            }
            SharedPref.set(key: 'totalAmount', value: totalAmount);
            SharedPref.set(key: 'amountBeforeTex', value: amountBeforeTex);
            SharedPref.set(key: 'taxAmount', value: taxAmount);
            return Column(
              children: [
                Divider(
                  thickness: 3,
                  height: 15.h,
                ),
                const GapH(h: 1),
                TextBuilder(
                  AppLocalizations.of(context)!.total_icludes_tax,
                ),
                const GapH(h: 1),
                getIt.get<AddItemCubit>().addedItems.isEmpty
                    ? TextBuilder(
                        "${SharedPref.get(key: 'totalAmount').toStringAsFixed(2) ?? totalAmount}",
                        fontSize: 40,
                      )
                    : TextBuilder(
                        "${SharedPref.get(key: 'totalAmount').toStringAsFixed(2) ?? 0.0}",
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
                          "${SharedPref.get(key: 'amountBeforeTex').toStringAsFixed(2) ?? 0.0}",
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
                          "${SharedPref.get(key: 'taxAmount').toStringAsFixed(2) ?? 0.0}",
                          maxLines: 2,
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                  height: 20.h,
                ),
                BlocBuilder<PaymentTypeCubit, PaymentTypeState>(
                  builder: (context, state) {
                    if (state is PaymentTypeSuccess) {
                      return ChoosePaymentType(
                        totalAmount: totalAmount,
                        payTypes: state.payTypes,
                      );
                    } else if (state is PaymentTypeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text(
                          "There is no payment type , Tell us your problem!");
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ChoosePaymentType extends StatelessWidget {
  ChoosePaymentType({
    super.key,
    required this.totalAmount,
    required this.payTypes,
  });

  final double totalAmount;
  final List<PaymentTypeModel> payTypes;

  final TextEditingController _controller = TextEditingController();
  double price = 0;

  @override
  Widget build(BuildContext context) {
    _controller.text = totalAmount.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: DropdownSearch<PaymentTypeModel>(
            items: payTypes,
            itemAsString: (PaymentTypeModel paymentTypeModel) =>
                paymentTypeModel.payname!,
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose, // << change this
              itemBuilder: (context, item, isSelected) {
                return Container(
                    padding: const EdgeInsets.all(10),
                    // alignment: Alignment.center,
                    child: TextBuilder(
                      item.payname!,
                      textAlign: TextAlign.center,
                      color: isSelected
                          ? AppColors.secondColorOrange
                          : AppColors.primaryColorBlue,
                    ));
              },
            ),
            dropdownButtonProps: const DropdownButtonProps(
              color: AppColors.primaryColorBlue,
            ),

            dropdownDecoratorProps: DropDownDecoratorProps(
              textAlign: TextAlign.center,
              baseStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlignVertical: TextAlignVertical.center,
              dropdownSearchDecoration: InputDecoration(
                  label: TextBuilder(
                    AppLocalizations.of(context)!.payment_types,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
            ),
            onChanged: (PaymentTypeModel? data) {
              debugPrint("${data!.payid}");
              debugPrint(data.payname);
              debugPrint(data.payename);
              debugPrint("${data.bankdtlId}");
              SharedPref.set(key: "paymentTypeID", value: data.payid ?? 0);
              SharedPref.set(key: "bankdtlId", value: data.bankdtlId ?? 1);
              SharedPref.set(
                  key: "paymentTypeName", value: data.payname ?? "Cash");
            },
            // selectedItem: itemSelected,
          ),
        ),
        const GapW(w: 5),
        Flexible(
          child: CustomTextFormField(
            centerContent: true,
            controller: _controller,
            labelText: _controller.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}')),
            ],
            onChange: (p0) {
              _controller.text = p0;
              price = p0 == "" || p0.isEmpty ? 0.0 : double.parse(p0);
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}

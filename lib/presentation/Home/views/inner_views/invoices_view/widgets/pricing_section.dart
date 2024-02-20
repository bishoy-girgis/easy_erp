import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/payment_type_model/pay_ment_type_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/invoice_cubit/cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/payment_type_cubit/cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/app_routing.dart';
import '../../../../../../core/helper/global_methods.dart';
import '../../../../../../core/helper/locator.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../data/models/customer_model/customer_model.dart';

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
                      return ChoocePaymentType(
                        totalAmount: totalAmount,
                        payTypes: state.payTypes,
                      );
                    } else if (state is PaymentTypeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text(
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

class ChoocePaymentType extends StatefulWidget {
  const ChoocePaymentType({
    super.key,
    required this.totalAmount,
    required this.payTypes,
  });

  final double totalAmount;
  final List<PaymentTypeModel> payTypes;
  @override
  State<ChoocePaymentType> createState() => _ChoocePaymentTypeState();
}

class _ChoocePaymentTypeState extends State<ChoocePaymentType> {
  TextEditingController _controller = TextEditingController();
  double price = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: AbsorbPointer(
            absorbing: price < widget.totalAmount,
            child: DropdownSearch<PaymentTypeModel>(
              items: widget.payTypes,
              itemAsString: (PaymentTypeModel paymentTypeModel) =>
                  paymentTypeModel.payname!,
              popupProps: PopupProps.dialog(
                itemBuilder: (context, item, isSelected) {
                  return Container(
                      padding: EdgeInsets.all(10),
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
              dropdownButtonProps: DropdownButtonProps(
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
                print(data!.payid);
                print(data.payname);
                print(data.payename);

                print(data.bankdtlId);

                setState(() {
                  SharedPref.set(key: "paymentTypeID", value: data.payid ?? 1);
                  SharedPref.set(key: "bankdtlId", value: data.bankdtlId ?? 1);
                });
                print(
                  SharedPref.get(key: "paymentTypeID"),
                );
              },
              // selectedItem: itemSelected,
            ),
          ),
        ),
        GapW(w: 5),
        Flexible(
          child: CustomTextFormField(
            controller: _controller,
            labelText: widget.totalAmount.toString(),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}')),
            ],
            onChange: (p0) {
              setState(() {
                _controller.text = p0;
                price = p0 == "" || p0.isEmpty ? 0.0 : double.parse(p0);
              });
            },
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}

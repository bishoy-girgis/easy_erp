// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_state.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoucherValuepaid extends StatefulWidget {
  const VoucherValuepaid({super.key});

  @override
  State<VoucherValuepaid> createState() => _VoucherValuepaidState();
}

class _VoucherValuepaidState extends State<VoucherValuepaid> {
  TextEditingController price = TextEditingController();
  double totalAmount = 0.0;
  double taxAmount = 0.0;
  bool withoutTax = false;
  List<PayerTypeModel> payers = [];

  void calculateTaxAndTotal(String value) {
    totalAmount = double.tryParse(value) ?? 0.0;
    setState(() {
      if (withoutTax) {
        taxAmount = 0.0;
      } else {
        taxAmount =
            ((AppConstants.vat * totalAmount) / (100 + AppConstants.vat));
      }
    });
    SharedPref.set(key: "paidVoucher", value: totalAmount);
    SharedPref.set(key: "taxVoucher", value: taxAmount);
    debugPrint('sharedddd paidddVoucher  ' +
        SharedPref.get(key: 'paidVoucher').toString());
    debugPrint('sharedddd TAXXXvoucher  ' +
        SharedPref.get(key: 'taxVoucher').toString());
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBuilder(
              AppLocalizations.of(context)!.payer_type,
              isHeader: true,
              fontSize: 13,
            ),
            BlocBuilder<PayerTypeCubit, PayerTypeState>(
              builder: (context, state) {
                if (state is PayerTypeLoading) {
                  return const CircularProgressIndicator();
                } else if (state is PayerTypeSuccess) {
                  // Use the data from state.payTypes to populate your Autocomplete widget
                  return autoComplete(state.payTypes);
                } else if (state is PayerTypeFail) {
                  // Show an error message
                  return Text(state.errorMessage);
                } else {
                  // Handle other states if necessary
                  return const Text('Check your Payers Account');
                }
              },
            ),
            const GapH(h: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBuilder(
                      AppLocalizations.of(context)!.total_icludes_tax,
                      isHeader: true,
                      fontSize: 13,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.price,
                      hintText: AppLocalizations.of(context)!.price,
                      prefixIcon: Icons.attach_money_outlined,
                      prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
                      prefixIconSize: 17.sp,
                      controller: price,
                      onChange: calculateTaxAndTotal,
                    ),
                  ],
                )),
                const GapW(w: 10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            activeColor:
                                const Color.fromARGB(255, 49, 101, 128),
                            value: withoutTax,
                            onChanged: (value) {
                              setState(() {
                                withoutTax = value!;
                                calculateTaxAndTotal(price.text);
                              });
                            },
                          ),
                          const GapW(w: 1),
                          TextBuilder(
                            AppLocalizations.of(context)!.without_tax,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(227, 227, 227, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextBuilder(
                              AppLocalizations.of(context)!.tax_amount,
                              isHeader: true,
                              fontSize: 13,
                            ),
                            TextBuilder(
                              taxAmount.toStringAsFixed(2),
                              isHeader: true,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const GapH(h: 3),
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
        ),
      ),
    );
  }

  Widget autoComplete(List<PayerTypeModel> payers) {
    PayerTypeModel emptyPayers = const PayerTypeModel();
    debugPrint("${payers.length}  payersLength");
    List<PayerTypeModel> kOptions = payers;
    return Autocomplete<PayerTypeModel>(
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            final PayerTypeModel option = options.elementAt(index);
            return GestureDetector(
              onTap: () {
                onSelected(option);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
                child: Text(
                  "Code: ${option.chartCode}    Name: ${option.accname}",
                  style: TextStyle(fontSize: 11.sp, color: Colors.white),
                ),
              ),
            );
          },
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return CustomTextFormField(
          labelText: AppLocalizations.of(context)!.payer,
          hintText: AppLocalizations.of(context)!.payer,
          prefixIcon: Icons.person_2_rounded,
          prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
          prefixIconSize: 16.sp,
          controller: textEditingController,
          focusNode: focusNode,
          onSubmit: (_) => onFieldSubmitted(),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<PayerTypeModel>.empty();
        }
        List<PayerTypeModel> filteredOptions = kOptions
            .where((payer) =>
                payer.accname!
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()) ||
                payer.chartCode!
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
            .toList();

        return filteredOptions.take(10);
      },
      onSelected: (PayerTypeModel selectedPayer) {
        if (selectedPayer != emptyPayers) {
          SharedPref.set(key: 'PayerChartId', value: selectedPayer.chartid!);
          SharedPref.set(key: 'PayerChartName', value: selectedPayer.accname!);

          GlobalMethods.buildFlutterToast(
            message: AppLocalizations.of(context)!.payerSelected,
            state: ToastStates.SUCCESS,
          );

          setState(() {});
        } else {
          GlobalMethods.buildFlutterToast(
            message:  AppLocalizations.of(context)!.noPayerFound,
            state: ToastStates.ERROR,
          );
        }
        debugPrint(
            "PAYER CHART ID pref ${SharedPref.get(key: 'PayerChartId')}");
      },
      displayStringForOption: (option) {
        debugPrint("${option.accname!}  select");
        return option.accname!;
      },
    );
  }
}

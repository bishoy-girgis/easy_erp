// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoucherValuepaid extends StatefulWidget {
  const VoucherValuepaid({super.key});

  static const List<String> _kOptions = <String>[
    'bishoy',
    'youssef',
    'ahmed',
  ];

  @override
  State<VoucherValuepaid> createState() => _VoucherValuepaidState();
}

class _VoucherValuepaidState extends State<VoucherValuepaid> {
  TextEditingController price = TextEditingController();

  double taxAmount = 0.0;

  double totalPrice = 0.0;
  bool withoutTax = false;
  double totalAmount = 0.0;

  void calculateTaxAndTotal(String value) {
    totalAmount = double.tryParse(value) ?? 0.0;
    setState(() {
      if (withoutTax) {
        taxAmount = 0.0;
        totalPrice = totalAmount;
      } else {
        taxAmount =
            ((AppConstants.vat * totalAmount) / (100 + AppConstants.vat));
        totalPrice = totalAmount - taxAmount;
      }
    });
    SharedPref.set(key: "paidVoucher", value: totalAmount);
    SharedPref.set(key: "taxvoucher", value: taxAmount);
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
            const TextBuilder(
              "Payer Account Type",
              isHeader: true,
              fontSize: 13,
            ),
            Autocomplete<String>(
              optionsViewBuilder: (context, onSelected, options) {
                return ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: const Color.fromRGBO(227, 227, 227, 1),
                        child: Text(
                          option,
                          style:
                              TextStyle(fontSize: 11.sp, color: Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return CustomTextFormField(
                  labelText: "Payer",
                  hintText: "Type Payer's Account",
                  prefixIcon: Icons.person_2_rounded,
                  prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
                  prefixIconSize: 16.sp,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmit: (_) => onFieldSubmitted(),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return VoucherValuepaid._kOptions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },
            ),
            const GapH(h: 1),
            const TextBuilder(
              "price Include Tax ",
              isHeader: true,
              fontSize: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: "price include tax",
                      hintText: "price include tax",
                      prefixIcon: Icons.person_2_rounded,
                      prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
                      prefixIconSize: 16.sp,
                      controller: price,
                      onChange: calculateTaxAndTotal,
                    ),
                    const GapH(h: 1),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color.fromRGBO(227, 227, 227, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const TextBuilder(
                            "Tax",
                            isHeader: true,
                            fontSize: 12,
                          ),
                          TextBuilder(
                            taxAmount.toStringAsFixed(2),
                            isHeader: true,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    const GapH(h: 1),
                    Row(
                      children: [
                        Checkbox(
                          value: withoutTax,
                          onChanged: (value) {
                            setState(() {
                              withoutTax = value!;
                              price.text = '';
                              calculateTaxAndTotal(price.text);
                            });
                          },
                        ),
                        const TextBuilder(
                          "Without Tax",
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ],
                )),
                const GapW(w: 7),
                Flexible(
                    child: Column(
                  children: [
                    const TextBuilder(
                      "price",
                      fontSize: 11,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color.fromRGBO(227, 227, 227, 1),
                      ),
                      child: Center(
                        child: TextBuilder(
                          totalPrice.toStringAsFixed(2),
                          isHeader: true,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )),
                const GapW(w: 7),
              ],
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
}
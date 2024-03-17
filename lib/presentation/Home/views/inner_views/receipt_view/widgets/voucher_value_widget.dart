// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoucherValuWidget extends StatefulWidget {
  const VoucherValuWidget({super.key});

  static const List<String> _kOptions = <String>[
    'bishoy',
    'youssef',
    'ahmed',
  ];

  @override
  State<VoucherValuWidget> createState() => _VoucherValuWidgetState();
}

class _VoucherValuWidgetState extends State<VoucherValuWidget> {
  TextEditingController voucherValue = TextEditingController();
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    voucherValue.addListener(_updateTotalAmount);
  }

  @override
  void dispose() {
    voucherValue.removeListener(_updateTotalAmount);
    super.dispose();
  }

  void _updateTotalAmount() {
    setState(() {
      totalAmount =
          voucherValue.text.isEmpty ? 0 : double.parse(voucherValue.text);
      SharedPref.set(key: "recieptVoucher", value: totalAmount);
      debugPrint('sharedddd recieptVoucher  ' +
          SharedPref.get(key: 'recieptVoucher').toString());
    });
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
              "Payer Account",
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
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 49, 101, 128),
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        child: Text(
                          option,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
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
                  hintText: "Search by Payer Name",
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
                return VoucherValuWidget._kOptions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                debugPrint('You just selected $selection');
              },
            ),
            const GapH(h: 1),
            const TextBuilder(
              "Voucher Value",
              isHeader: true,
              fontSize: 13,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: voucherValue,
              labelText: "Voucher",
              hintText: "Voucher Value ...",
              prefixIcon: Icons.attach_money,
              prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
              prefixIconSize: 16.sp,
            ),
            const GapH(h: 1),
            const TextBuilder(
              "Payment Types",
              isHeader: true,
              fontSize: 13,
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

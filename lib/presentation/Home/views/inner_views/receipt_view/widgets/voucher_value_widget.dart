// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoucherValuWidget extends StatefulWidget {
  const VoucherValuWidget({super.key});

  @override
  State<VoucherValuWidget> createState() => _VoucherValuWidgetState();
}

class _VoucherValuWidgetState extends State<VoucherValuWidget> {
  TextEditingController voucherValue = TextEditingController();
  double totalAmount = 0;
  List<PayerTypeModel> payers = [];

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
            TextBuilder(
              AppLocalizations.of(context)!.payer_account,
              isHeader: true,
              fontSize: 13,
            ),
            autoComplete(),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.voucher_value,
              isHeader: true,
              fontSize: 13,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: voucherValue,
              labelText: AppLocalizations.of(context)!.voucher,
              hintText: AppLocalizations.of(context)!.voucher_value,
              prefixIcon: Icons.attach_money,
              prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
              prefixIconSize: 16.sp,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.payment_types,
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

  Widget autoComplete() {
    PayerTypeModel emptyPayers = const PayerTypeModel();
    getIt.get<PayerTypeCubit>().getPayerTypes(type: 1);
    payers = getIt.get<PayerTypeCubit>().payerModels;
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
          GlobalMethods.buildFlutterToast(
            message: 'Payer Selected Successfully',
            state: ToastStates.SUCCESS,
          );
          SharedPref.set(key: 'PayerChartId', value: selectedPayer.chartid!);

          setState(() {});
        } else {
          GlobalMethods.buildFlutterToast(
            message: 'No Payers found for the entered Code.',
            state: ToastStates.ERROR,
          );
        }
        print(
            "PAYYERRR CHARRT IDDD pref ${SharedPref.get(key: 'PayerChartId')}");
      },
      displayStringForOption: (option) {
        print("${option.accname!}  selecttttttttttt");
        return option.accname!;
      },
    );
  }
}

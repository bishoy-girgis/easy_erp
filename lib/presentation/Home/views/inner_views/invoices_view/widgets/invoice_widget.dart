import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/models/invoice_model/invoice_model.dart';
import '../../../../../cubits/invoice_cubit/invoice_cubit.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.invoiceModel,
  });
  final InvoiceModel invoiceModel;
  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.secondColorOrange,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: TextBuilder(
                  formatDate(invoiceModel.invdate!),
                  textAlign: TextAlign.center,
                  fontSize: 15,
                  color: AppColors.whiteColor,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/invoice.png"),
                          size: 18.sp,
                        ),
                        // Icon(
                        //   Icons.inventory_2_outlined,
                        //   size: 25.sp,
                        // ),
                        const GapW(w: 5),
                        TextBuilder(
                          invoiceModel.invNo!,
                          fontSize: 17,
                        ),
                      ],
                    ),
                    const Divider(),
                    TextBuilder(
                      invoiceModel.custInvname!,
                      fontSize: 17,
                    ),
                    const GapH(h: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextBuilder(
                              AppLocalizations.of(context)!.total_icludes_tax,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                            ),
                            TextBuilder(
                              invoiceModel.finalValue.toString(),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextBuilder(
                              AppLocalizations.of(context)!.tax_amount,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                            ),
                            TextBuilder(invoiceModel.taxAdd.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

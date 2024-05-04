import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_cubit.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Recieptwidget extends StatelessWidget {
  const Recieptwidget({super.key, required this.recieptModel});
  final RecieptModel recieptModel;

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Recieptcubit, RecieptState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin:  EdgeInsets.symmetric(vertical: 5.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(1, 1),
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding:  EdgeInsets.all(5.sp),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 49, 101, 128),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: TextBuilder(
                  formatDate(recieptModel.date!),
                  textAlign: TextAlign.center,
                  fontSize: 15,
                  color: AppColors.whiteColor,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 3.h
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          const AssetImage("assets/images/product-returnn.png"),
                          size: 20.sp,
                        ),
                        const GapW(w: 5),
                        TextBuilder(
                          recieptModel.cashinOrdno.toString(),
                          fontSize: 17,
                        ),
                      ],
                    ),
                    const GapH(h: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextBuilder(
                              recieptModel.custchartName!,
                              fontSize: 17,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextBuilder(
                              AppLocalizations.of(context)!.totalItemsInvoice,
                              textAlign: TextAlign.center,
                              fontSize: 13,
                            ),
                            TextBuilder(
                              recieptModel.recvalue.toString(),
                            ),
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

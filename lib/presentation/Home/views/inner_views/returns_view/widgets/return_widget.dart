import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/return/return_model.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ReturnWidget extends StatelessWidget {
  const ReturnWidget({super.key, required this.returnModel});

  final ReturnModel returnModel;
  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Returncubit, ReturnState>(
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
                decoration: BoxDecoration(
                  color: AppColors.primaryColorBlue.withOpacity(0.72),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: TextBuilder(
                  formatDate(returnModel.rtnInvdate!),
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
                          const AssetImage("assets/images/product-returnn.png"),
                          size: 20.sp,
                        ),
                        // Icon(
                        //   Icons.inventory_2_outlined,
                        //   size: 20.sp,
                        // ),
                        const GapW(w: 5),
                        TextBuilder(
                          returnModel.rtnInvNo!,
                          fontSize: 17,
                        ),
                      ],
                    ),
                    const Divider(),
                    TextBuilder(
                      
                      returnMode
                      
                      fontSize: 
                      
                    ),
                    const GapH(h
                    
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
                              returnModel.finalValue.toString(),
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
                            TextBuilder(returnModel.taxAdd.toString()),
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

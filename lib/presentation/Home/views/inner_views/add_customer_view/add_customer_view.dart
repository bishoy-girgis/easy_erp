import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/models/payment_type_model/pay_ment_type_model.dart';

class AddCustomerView extends StatelessWidget {
  const AddCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          "Add Customer",
          color: AppColors.whiteColor,
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextBuilder(
            "ADD Customer Data",
            color: AppColors.whiteColor,
          ),
          GapH(h: 5),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Form(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomTextFormField(labelText: 'Customer name AR'),
                  CustomTextFormField(labelText: 'Customer name EN'),
                  CustomTextFormField(labelText: 'Fax'),
                  CustomTextFormField(labelText: 'Mobile number'),
                  CustomTextFormField(labelText: 'Address ar'),
                  CustomTextFormField(labelText: 'Address en'),
                  CustomTextFormField(labelText: 'Managet name ar'),
                  CustomTextFormField(labelText: 'Managet name en'),
                ],
              ),
            )),
          ),
          GapH(h: 2),
          //   Card(child: Flexible(
          //   child: DropdownSearch<PaymentTypeModel>(
          //     items: widget.payTypes,
          //     itemAsString: (PaymentTypeModel paymentTypeModel) =>
          //         paymentTypeModel.payname!,
          //     popupProps: PopupProps.dialog(
          //       itemBuilder: (context, item, isSelected) {
          //         return Container(
          //             padding: EdgeInsets.all(10),
          //             // alignment: Alignment.center,
          //             child: TextBuilder(
          //               item.payname!,
          //               textAlign: TextAlign.center,
          //               color: isSelected
          //                   ? AppColors.secondColorOrange
          //                   : AppColors.primaryColorBlue,
          //             ));
          //       },
          //     ),
          //     dropdownButtonProps: DropdownButtonProps(
          //       color: AppColors.primaryColorBlue,
          //     ),

          //     dropdownDecoratorProps: DropDownDecoratorProps(
          //       textAlign: TextAlign.center,
          //       baseStyle: TextStyle(
          //         fontFamily: 'Cairo',
          //         fontSize: 16.sp,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       textAlignVertical: TextAlignVertical.center,
          //       dropdownSearchDecoration: InputDecoration(
          //           label: TextBuilder(
          //             AppLocalizations.of(context)!.payment_types,
          //             fontSize: 14,
          //             maxLines: 2,
          //           ),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(16),
          //           )),
          //     ),
          //     onChanged: (PaymentTypeModel? data) {
          //       print(data!.payid);
          //       print(data.payname);
          //       print(data.payename);

          //       print(data.bankdtlId);

          //       setState(() {
          //         SharedPref.set(key: "paymentTypeID", value: data.payid ?? 1);
          //         SharedPref.set(key: "bankdtlId", value: data.bankdtlId ?? 1);
          //       });
          //       print(
          //         SharedPref.get(key: "paymentTypeID"),
          //       );
          //     },
          //     // selectedItem: itemSelected,
          //   ),
          // ), ,)
        ],
      ),
    );
  }
}

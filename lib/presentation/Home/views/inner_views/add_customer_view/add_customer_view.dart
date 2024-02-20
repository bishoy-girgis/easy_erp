import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/cubits/customer_cubit/customer_cubit.dart';
import 'package:easy_erp/data/models/group_model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data/models/payment_type_model/pay_ment_type_model.dart';
import '../../../../../data/services/local/shared_pref.dart';
import 'widgets/select_group_section.dart';

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
      child: Form(
        child: Column(
          children: [
            TextBuilder(
              "ADD Customer Data",
              color: AppColors.whiteColor,
            ),
            GapH(h: 5),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                    GapH(h: 2),
                    ChooseGroup()
                  ],
                ),
              ),
            ),
            GapH(h: 5),
            CustomElevatedButton(
              backgroundColor: Colors.white,
              title: TextBuilder(
                "Add Customer",
              ),
            )
          ],
        ),
      ),
    );
  }
}

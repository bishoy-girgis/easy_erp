import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';

import 'widgets/pick_date_widget.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          "Create Invoice",
          isHeader: true,
          color: AppColors.whiteColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    TextBuilder(
                      "Invoice ID",
                      isHeader: true,
                    ),
                    CustomTextFormField(
                      labelText: "AUTO ",
                      isClickable: false,
                    ),
                    Row(
                      children: [
                        Flexible(child: DatePickerWidget()),
                        GapW(w: 1),
                        Flexible(child: HoursAndMinutes()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import 'pick_date_widget.dart';
import 'search_on_customer_name_section.dart';
import 'sellect_cash_or_postpon_section.dart';

class InvoiceMainDataSection extends StatelessWidget {
  const InvoiceMainDataSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBuilder(
              "Invoice ID",
              isHeader: true,
              fontSize: 16,
            ),
            CustomTextFormField(
              labelText: "AUTO ",
              centerContent: true,
              isLabelBold: true,
              isClickable: false,
              // readOnly: true,
            ),
            GapH(h: 1),
            TextBuilder(
              "Invoice Date",
              isHeader: true,
              fontSize: 16,
            ),
            Row(
              children: [
                Flexible(child: DatePickerWidget()),
                GapW(w: 1),
                Flexible(child: HoursAndMinutes()),
              ],
            ),
            SearchOnCustomerNameSection(),
            GapH(h: 1),
            TextBuilder(
              "Invoice Type",
              isHeader: true,
              fontSize: 16,
            ),
            SellectCashOrPostponeSection(),
          ],
        ),
      ),
    );
  }
}

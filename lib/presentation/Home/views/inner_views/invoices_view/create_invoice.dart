import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          child: CustomScrollView(slivers: [InvoiceMainDataSection()]),
        ),
      ),
    );
  }
}

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
            searchOnCustomerNameSection(),
            GapH(h: 1),
            TextBuilder(
              "Invoice Type",
              isHeader: true,
              fontSize: 16,
            ),
            SellectCashOrPostponeSection(),
            GapH(h: 1),
          ],
        ),
      ),
    );
  }
}

class SellectCashOrPostponeSection extends StatefulWidget {
  const SellectCashOrPostponeSection({super.key});

  @override
  State<SellectCashOrPostponeSection> createState() =>
      _SellectCashOrPostponeSectionState();
}

class _SellectCashOrPostponeSectionState
    extends State<SellectCashOrPostponeSection> {
  String selectedOption = 'In-Cash';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        child: DropdownButton<String>(
          value: selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: <String>[
            'In-Cash',
            'Postpone',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextBuilder(
                value,
                isHeader: true,
                fontSize: 14,
                color: Colors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class searchOnCustomerNameSection extends StatelessWidget {
  const searchOnCustomerNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.person,
      labelText: "Customer name",
      hintText: "search on customer name",
      isLabelBold: true,
    );
  }
}

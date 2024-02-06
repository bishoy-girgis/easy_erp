import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/Invoice-main_data_section.dart';
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
            InvoiceMainDataSection(),
            SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            SliverToBoxAdapter(
              child: CustomElevatedButton(
                title: Text("FFF"),
                onPressed: () {
                  GlobalMethods.goRouterNavigateTO(
                      context: context,
                      router: AppRouters.kAddItemsIntoInvoice);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

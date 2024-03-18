import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pick_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecieptMainData extends StatelessWidget {
  const RecieptMainData({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
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
              AppLocalizations.of(context)!.voucher_id,
              isHeader: true,
              fontSize: 13,
            ),
            CustomTextFormField(
              labelText: AppLocalizations.of(context)!.auto,
              centerContent: true,
              isLabelBold: true,
              isClickable: false,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.voucher_date,
              isHeader: true,
              fontSize: 13,
            ),
            const Row(
              children: [
                Flexible(child: DatePickerWidget()),
                GapW(w: 1),
                Flexible(child: HoursAndMinutes()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

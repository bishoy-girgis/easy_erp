import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellectCashOrCreditSection extends StatefulWidget {
  const SellectCashOrCreditSection({super.key});

  @override
  State<SellectCashOrCreditSection> createState() =>
      _SellectCashOrCreditSectionState();
}

class _SellectCashOrCreditSectionState
    extends State<SellectCashOrCreditSection> {
  @override
  Widget build(BuildContext context) {
    // String selectedOption = AppLocalizations.of(context)!.cash;
    String dropdownvalue = AppLocalizations.of(context)!.cash;

    var items = [
      AppLocalizations.of(context)!.cash,
      AppLocalizations.of(context)!.credit,
    ];
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        child: DropdownButton(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: TextBuilder(items),
            );
          }).toList(),
        ),
      ),
    );
  }
}

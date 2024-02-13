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
    String selectedOption = AppLocalizations.of(context)!.cash;

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
            AppLocalizations.of(context)!.cash,
            AppLocalizations.of(context)!.credit,
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextBuilder(
                value,
                // isHeader: true,
                fontSize: 18,
                color: Colors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:easy_erp/data/services/local/shared_pref.dart';
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
  String? _dropdownValue;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;

        if (_dropdownValue == AppLocalizations.of(context)!.cash) {
          SharedPref.set(key: 'invoiceTypeID', value: 0);
          debugPrint("${SharedPref.get(key: 'invoiceTypeID')}");
        } else {
          SharedPref.set(key: 'invoiceTypeID', value: 2);
          debugPrint("${SharedPref.get(key: 'invoiceTypeID')}");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      AppLocalizations.of(context)!.cash,
      AppLocalizations.of(context)!.credit,
    ];
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 5.h),
        width: double.infinity,
        child: DropdownButton(
          hint: TextBuilder(
            AppLocalizations.of(context)!.cash,
          ),
          isExpanded: true,
          value: _dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: dropdownCallback,
          items: items.map((String items) {
            return DropdownMenuItem(
              alignment: Alignment.centerRight,
              value: items,
              child: TextBuilder(items),
            );
          }).toList(),
        ),
      ),
    );
  }
}

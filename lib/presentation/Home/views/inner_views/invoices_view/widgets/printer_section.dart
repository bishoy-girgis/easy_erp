import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../data/services/local/shared_pref.dart';

class PrinterSection extends StatelessWidget {
  const PrinterSection({
    super.key,
    required this.isMenuOpen,
    required this.onPrinterFormatSelected,
  });

  final bool isMenuOpen;
  final void Function() onPrinterFormatSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isMenuOpen ? 110.h : 0,
      width: isMenuOpen ? 40.w : 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isMenuOpen
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                SharedPref.set(key: 'printerFormat', value: 0);
                onPrinterFormatSelected();
              },
              child: TextBuilder("A4", fontSize: 9),
            ),
            const Divider(color: Colors.white),
            InkWell(
              onTap: () {
                SharedPref.set(key: 'printerFormat', value: 1);
                onPrinterFormatSelected();
              },
              child: TextBuilder("POS", fontSize: 9),
            ),
            const Divider(color: Colors.white),
            InkWell(
              onTap: () {
                SharedPref.set(key: 'printerFormat', value: 2);
                onPrinterFormatSelected();
              },
              child: TextBuilder("RECEIPT", fontSize: 9),
            ),
          ],
        )
            : null,
      ),
    );
  }
}

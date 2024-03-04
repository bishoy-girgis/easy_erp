import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';
import '../../../../data/models/printerModel/printer_model.dart';

class ChoosePrintModelSection extends StatefulWidget {
  const ChoosePrintModelSection({
    super.key,
  });

  @override
  State<ChoosePrintModelSection> createState() =>
      _ChoosePrintModelSectionState();
}

class _ChoosePrintModelSectionState extends State<ChoosePrintModelSection> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const TextBuilder(
              "Choose Print Model",
              isHeader: true,
            ),
            const Divider(),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTextButton(PrinterModel(
                      name: 'A4', id: 0, format: PdfPageFormat.a4)),
                  const VDividerBuilder(),
                  buildTextButton(PrinterModel(
                      name: 'POS', id: 1, format: PdfPageFormat.roll57)),
                  const VDividerBuilder(),
                  buildTextButton(PrinterModel(
                      name: 'RECEIPT', id: 2, format: PdfPageFormat.roll80)),
                ],
              ),
            ),
            const TextBuilder(
              "You have selected the Print Model \n example : POS",
              maxLines: 2,
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextButton(PrinterModel printerModel) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = printerModel.id;
            SharedPref.set(key: 'printerFormat', value: selectedButtonIndex);
          });
          print(SharedPref.get(key: 'printerFormat'));
          print("ppppppp" + selectedButtonIndex.toString());
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return selectedButtonIndex == printerModel.id
                  ? AppColors.primaryColorBlue
                  : AppColors.secondColorOrange;
            },
          ),
        ),
        child: Text(
          printerModel.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class VDividerBuilder extends StatelessWidget {
  const VDividerBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      color: AppColors.blackColor,
      height: 20.h,
    );
  }
}

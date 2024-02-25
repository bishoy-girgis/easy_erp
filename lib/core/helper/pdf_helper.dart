import 'dart:io';

import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/data/models/printerModel/printer_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../data/cubits/addItem_cubit/cubit/add_item_cubit.dart';
import '../../data/models/invoice_model/invoice_model.dart';
import '../../data/models/item_model/item_model.dart';

Future<void> generateAndPrintArabicPdf(
  context, {
  invNo,
  required double netvalue,
  required double taxAdd,
  required double finalValue,
  required String custName,
  required String invoiceType,
  required List<ItemModel> items,
}) async {
  // double netvalue = SharedPref.get(key: 'amountBeforeTex');
  // double taxAdd = SharedPref.get(key: 'taxAmount');
  // double finalValue = SharedPref.get(key: 'totalAmount');
  // String custName = SharedPref.get(key: 'custName') ?? 'cash';
  List<dynamic> getItems() {
    List<dynamic> finalItems = [];
    var length = items.length;
    for (int i = 0; i < length; i++) {
      finalItems.add([
        items[i].salesprice.toString(),
        items[i].discP.toString(),
        items[i].cost.toString(),
        items[i].quantity.toString(),
        items[i].itmname ?? items[i].itmename ?? "None",
      ]);
    }
    return finalItems;
  }

  var itemsList = getItems();
  final Document pdf = Document();
  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));
  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.letter,
      build: (Context context) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildPDFText(invoiceType, fontSize: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(invNo.toString()),
                buildPDFText('رقم الفاتورة : '),
              ]),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   buildPDFText(SharedPref.get(key: 'invoiceDate')),
              //   buildPDFText('التاريخ : '),
              // ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(custName),
                buildPDFText('العميل : '),
              ]),
              buildPDFText('الأصناف : '),
              Container(
                margin: const EdgeInsets.fromLTRB(22, 5, 22, 5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TableHelper.fromTextArray(
                    headerStyle: const TextStyle(fontSize: 15),
                    headers: <dynamic>[
                      'الإجمالي',
                      'الخصم',
                      'السعر',
                      'الكمية',
                      'الصنف'
                    ],
                    cellAlignment: Alignment.center,
                    cellStyle: const TextStyle(fontSize: 12),
                    data: <List<dynamic>>[...itemsList],
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(netvalue.toStringAsFixed(2)),
                buildPDFText(
                  'الإجمالي قبل الضريبة : ',
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(taxAdd.toStringAsFixed(2)),
                buildPDFText(
                  'قيمة الضريبة : ',
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(finalValue.toStringAsFixed(2)),
                buildPDFText("الإجمالي شامل الضريبة : "),
              ]),
            ],
          ),
        );
      },
    ),
  );

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
  debugPrint("itemBox is clear now 🐸🐸");
  Hive.box<ItemModel>('itemBox').clear();
  getIt.get<AddItemCubit>().addedItems.clear();
}

Directionality buildPDFText(String text, {double fontSize = 18}) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: fontSize,
              ))));
}

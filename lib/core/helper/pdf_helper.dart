import 'dart:io';

import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../data/models/invoice_model/invoice_model.dart';
import '../../data/models/item_model/item_model.dart';

Future<void> generateAndPrintArabicPdf(
  context, {
  invNo,
  required String invoiceType,
  required List<ItemModel> items,
}) async {
  String custInvname = SharedPref.get(key: 'custName');
  String netvalue = SharedPref.get(key: 'amountBeforeTex');
  String taxAdd = context.get(key: 'taxAmount');
  String finalValue = SharedPref.get(key: 'totalAmount');
  String custName = SharedPref.get(key: 'custName') ?? 'cash';
  String invoiceDate = SharedPref.get(key: 'invoiceDate');

  final Document pdf = Document();

  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));
  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildPDFText(invoiceType, fontSize: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(invNo),
                buildPDFText('رقم الفاتورة : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(finalValue),
                buildPDFText('التاريخ : '),
              ]),
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
                    cellStyle: const TextStyle(fontSize: 5),
                    data: <List<dynamic>>[
                      [
                        items[0].salesprice.toString(),
                        items[0].discP.toString(),
                        items[0].cost.toString(),
                        items[0].quantity.toString(),
                        items[0].itmname ?? items[0].itmename ?? "None",
                      ],
                      [
                        items[1].salesprice.toString(),
                        items[1].discP.toString(),
                        items[1].cost.toString(),
                        items[1].quantity.toString(),
                        items[1].itmname ?? items[0].itmename ?? "None",
                      ],
                    ],
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  50  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('المجموع الفرعي : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  -20  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('خصم العميل : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  1  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('خصم عددي : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  29  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('الإجمالي : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  مدفوعة  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('حالة الفاتورة : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('  نقدا  ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text('طريقة الدفع : ',
                            style: const TextStyle(
                              fontSize: 10,
                            )))),
              ]),
            ],
          ),
        );
      },
    ),
  );
  Hive.box<ItemModel>('itemBox').clear();
  debugPrint("ffff");
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
}

Directionality buildPDFText(String text, {double fontSize = 15}) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: fontSize,
              ))));
}

import 'dart:io';

import 'package:easy_erp/core/widgets/gap.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../data/models/invoice_model/invoice_model.dart';
import '../../data/models/item_model/item_model.dart';

Future<void> generateAndPrintArabicPdf(
  context, {
  required InvoiceModel invoiceModel,
  required String invoiceType,
  required List<ItemModel> items,
}) async {
  final Document pdf = Document();

  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));
  pdf.addPage(Page(
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
                buildPDFText(invoiceModel.invNo.toString()),
                buildPDFText('رقم الفاتورة : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(invoiceModel.invdate.toString()),
                buildPDFText('التاريخ : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(invoiceModel.invdate.toString()),
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
            ]));
      }));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
  // final directory = await getExternalStorageDirectory();
  // final filee = File("${directory?.path}/example.pdf");

  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.toList());
}

Directionality buildPDFText(String text, {double fontSize = 10}) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: fontSize,
              ))));
}

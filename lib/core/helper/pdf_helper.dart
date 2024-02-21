import 'dart:io';

import 'package:easy_erp/core/widgets/gap.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../data/models/invoice_model/invoice_model.dart';
import '../../data/models/item_model/item_model.dart';

// Future<Uint8List> pdfBuilder(
//   InvoiceModel invoiceModel,
//   String invoiceType,
//   List<ItemModel> items,
// ) async {
//   final pdf = Document();
//   var arabicFont = Font.ttf(
//       await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));

//   pdf.addPage(
//     Page(
//       theme: ThemeData.withFont(
//         base: arabicFont,
//       ),
//       pageFormat: PdfPageFormat.a4,
//       build: (context) {
//         return Column(
//           children: [
//             Text(invoiceType),
//             Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Center(
//                     child: Text('عادل الفات',
//                         style: TextStyle(
//                           fontSize: 10,
//                         )))),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Text('رقم الفاتورة : '),
//                 Text(invoiceModel.invNo ?? "00"),
//                 Text('التاريخ: '),
//                 Text(invoiceModel.invdate ?? "00/00/0000"),
//               ],
//             ),
//             Row(
//               children: [
//                 Text('العميل : '),
//                 Text(invoiceModel.custInvname ?? "نقدي"),
//               ],
//             ),
//             Text('الأصناف'),
//             Table(
//               border: TableBorder.all(color: PdfColors.black),
//               children: [
//                 TableRow(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Text(
//                         'BILL FOR PAYMENT',
//                         style: Theme.of(context).header4,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // ...invoiceModel.itms.map(
//                 //   (e) => TableRow(
//                 //     children: [
//                 //       Expanded(
//                 //         flex: 2,
//                 //         child: textAndPadding(e.itmname!),
//                 //       ),
//                 //       Expanded(
//                 //         flex: 1,
//                 //         child: textAndPadding("${e.salesprice}"),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 // TableRow(
//                 //   children: [
//                 //     textAndPadding('TAX', align: TextAlign.right),
//                 //     textAndPadding(
//                 //         '${(invoiceModel.totalCost() * 0.15).toStringAsFixed(2)}'),
//                 //   ],
//                 // ),
//                 // TableRow(
//                 //   children: [
//                 //     textAndPadding('TOTAL', align: TextAlign.right),
//                 //     textAndPadding(
//                 //         '/$${(invoiceModel.totalCost() * 1.1).toStringAsFixed(2)}')
//                 //   ],
//                 // )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Text(
//                 "THANK YOU FOR YOUR CUSTOM!",
//                 style: Theme.of(context).header2,
//               ),
//             ),
//             Text(
//                 "Please forward the below slip to your accounts payable department."),
//             Divider(
//               height: 1,
//             ),
//             Container(height: 50),
//             Table(
//               border: TableBorder.all(color: PdfColors.black),
//               children: [
//                 TableRow(
//                   children: [
//                     textAndPadding('Account Number'),
//                     textAndPadding(
//                       '1234 1234',
//                     )
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     textAndPadding(
//                       'Account Name',
//                     ),
//                     textAndPadding(
//                       'ADAM FAMILY TRUST',
//                     )
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     textAndPadding(
//                       'Total Amount to be Paid',
//                     ),
//                     textAndPadding('\$${(invoiceModel.custInvname)}')
//                   ],
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(30),
//               child: Text(
//                 'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
//                 style: Theme.of(context).header2,
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         );
//       },
//     ),
//   );
//   return pdf.save();
// }

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
              buildPDFText(invoiceType),
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

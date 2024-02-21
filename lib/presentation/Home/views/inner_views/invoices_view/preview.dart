// // import 'package:easy_erp/data/models/item_model/item_model.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:printing/printing.dart';

// // import '../../../../../core/helper/pdf_helper.dart';
// // import '../../../../../data/models/invoice_model/invoice_model.dart';

// // class PdfPreviewPage extends StatelessWidget {
// //   final InvoiceModel invoiceModel;
// //   // final List<ItemModel> items;
// //   const PdfPreviewPage({
// //     Key? key,
// //     required this.invoiceModel,
// //     // required this.items,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Your Invoice review '),
// //       ),
// //       body: InteractiveViewer(
// //         panEnabled: false,
// //         boundaryMargin: const EdgeInsets.all(80),
// //         minScale: 0.5,
// //         maxScale: 4,
// //         child: PdfPreview(
// //           loadingWidget: const CupertinoActivityIndicator(),
// //           build: (context) => pdfBuilder(invoiceModel, 'فاتورة الكترونية', []),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../../core/helper/pdf_helper.dart';

// class PrintBillInArabic extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('Arabic Bill Printing'),
//         ),
//       ),
//       body: Container(
//         child: ElevatedButton(
//           onPressed: () {
//             generateAndPrintArabicPdf(context);
//           },
//           // color: Color(0xffff9900),
//           child: Text(
//             'Print Arabic Bill',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/app_images.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:spelling_number/spelling_number.dart';
import '../../data/models/item_model/item_model.dart';
import '../../presentation/cubits/addItem_cubit/add_item_cubit.dart';

Future<void> generateAndPrintArabicPdf(
  context, {
  invNo,
  bool isReturn = false,
  required String qrData,
  required String invoDate,
  required String invoTime,
  required double netvalue,
  required double taxAdd,
  required double finalValue,
  required String custName,
  required String invoiceType,
  required List<ItemModel> items,
}) async {
  List<dynamic> getItems() {
    List<dynamic> finalItems = [];
    var length = items.length;
    for (int i = 0; i < length; i++) {
      finalItems.add([
        (items[i].salesprice! * items[i].quantity).toString(),
        items[i].discP.toString(),
        items[i].salesprice.toString(),
        items[i].quantity.toString(),
        items[i].itmname ?? items[i].itmename ?? "None",
      ]);
    }
    return finalItems;
  }

  Uint8List? imageData;
  String? imagePath = await SharedPref.get(key: "logoPath");
  if (imagePath != null) {
    File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      imageData = await imageFile.readAsBytes();
    } else {
      final ByteData image = await rootBundle.load(AppImages.logo);
      imageData = (image).buffer.asUint8List();
    }
  } else {
    final ByteData image = await rootBundle.load(AppImages.logo);
    imageData = (image).buffer.asUint8List();
  }

  int printType = SharedPref.get(key: 'printerFormat') ?? 0; // 0 = A4 print \\\\ 1,2 = RECEIPT POS print
  var itemsList = getItems();
  final Document pdf = Document();
  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));
  pdf.addPage(
    MultiPage(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.letter,
      build: (Context context) {
        if (printType != 0) {
          return [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 50.w,
                        height: 50.h,
                        child: Image(MemoryImage(imageData!))),
                    Container()
                  ],
                ),
                SizedBox(height: 8.h),
                buildPDFText(AppConstants.branchName, fontSize: 15),
                buildPDFText(invoiceType),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildPDFText(AppConstants.taxNumber),
                    buildPDFText('الرقم الضريبي : '),
                  ],
                ),
                SizedBox(height: 5.h),
                buildDottedDivider(),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(
                        child: Text(
                          custName,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                    buildPDFText('العميل : '),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(children: [
                      buildPDFText(invoTime),
                      buildPDFText('  الوقت : '),
                    ]),
                    buildPDFText(invoDate),
                    buildPDFText('التاريخ : '),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TableHelper.fromTextArray(
                      headerAlignment: Alignment.center,
                      columnWidths: {
                        0: const FixedColumnWidth(90),
                        1: const FlexColumnWidth(75),
                        2: const FixedColumnWidth(75),
                        3: const FixedColumnWidth(75),
                        4: const FixedColumnWidth(165),
                      },
                      headerStyle: TextStyle(fontSize: 9.sp),
                      headers: <dynamic>[
                        'الإجمالي',
                        'الخصم',
                        'السعر',
                        'الكمية',
                        'الصنف'
                      ],
                      cellAlignment: Alignment.center,
                      cellStyle: TextStyle(fontSize: 12.5.sp),
                      data: <List<dynamic>>[...itemsList],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPDFText(netvalue.toStringAsFixed(2)),
                    buildPDFText(
                      'الإجمالي قبل الضريبة : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPDFText(taxAdd.toStringAsFixed(2)),
                    buildPDFText(
                      'قيمة الضريبة : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPDFText(finalValue.toStringAsFixed(2)),
                    buildPDFText("الإجمالي شامل الضريبة : "),
                  ],
                ),
                buildPDFText(
                    "${SpellingNumber(lang: 'ar').convert(finalValue)} ريال سعودى فقط لا غير",
                    fontSize: 14),
                SizedBox(height: 5.h),
                buildDottedDivider(),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPDFText(invNo.toString()),
                    buildPDFText(
                        isReturn ? 'رقم المرتجع : ' : 'رقم الفاتورة : '),
                  ],
                ),
                SizedBox(height: 10.h),
                BarcodeWidget(
                    data: qrData,
                    barcode: Barcode.qrCode(),
                    height: 90.h,
                    width: 105.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPDFText(AppConstants.notes, fontSize: 13),
                  ],
                ),
                SizedBox(height: 5.h),
                buildDottedDivider(),
                SizedBox(height: 5.h),
              ],
            )
          ];
        } else {
          return [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 50.w,
                          height: 50.h,
                          child: Image(MemoryImage(imageData!))),
                      Column(
                        children: [
                          buildPDFText(AppConstants.branchName, ),
                          buildPDFText(AppConstants.taxNumber, ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  buildPDFText(invoiceType),
                  SizedBox(height: 5.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BarcodeWidget(
                            data: qrData,
                            barcode: Barcode.qrCode(),
                            height: 60.h,
                            width: 75.w),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildPDFText(invNo.toString()),
                                    buildPDFText(isReturn
                                        ? 'رقم المرتجع : '
                                        : 'رقم الفاتورة : '),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Center(
                                        child: Text(
                                          custName,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style:  TextStyle(
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildPDFText('العميل : '),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildPDFText(invoDate),
                                    buildPDFText('التاريخ : '),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildPDFText(invoTime),
                                    buildPDFText('الوقت : '),
                                  ]),
                            ]),
                      ]),
                  SizedBox(height: 10.h),
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
                        cellStyle: const TextStyle(fontSize: 15),
                        data: <List<dynamic>>[...itemsList],
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    buildPDFText(netvalue.toStringAsFixed(2)),
                    buildPDFText(
                      'الإجمالي قبل الضريبة : ',
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    buildPDFText(taxAdd.toStringAsFixed(2)),
                    buildPDFText(
                      'قيمة الضريبة : ',
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    buildPDFText(finalValue.toStringAsFixed(2)),
                    buildPDFText("الإجمالي شامل الضريبة : "),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    buildPDFText(AppConstants.notes,),
                  ]),
                ],
              ),
            )
          ];
        }
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
  getIt.get<InvoiceCubit>().removeInvoiceData();
}

Directionality buildPDFText(String text, {double fontSize = 15}) {
  int printType = SharedPref.get(key: 'printerFormat') ?? 0; // 0 = A4 print \\\\ 1,2 = RECEIPT POS print
   fontSize = printType != 0 ? 15 : 10;

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize.sp,
        ),
      ),
    ),
  );
}

buildDottedDivider() {
  const double dashWidth = 5;
  const double dashSpace = 3;
  final numberOfDashes =
      (PdfPageFormat.a4.width / (dashWidth + dashSpace)).floor();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(numberOfDashes, (index) {
      return Container(
        width: dashWidth,
        height: 1,
        color: PdfColors.black,
        //margin: const EdgeInsets.symmetric(horizontal: dashSpace),
      );
    }),
  );
}

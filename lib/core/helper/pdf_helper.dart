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
      String? fax,
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
  int printType = SharedPref.get(key: 'printerFormat') ?? 0;

  List<dynamic> getItems() {
    List<dynamic> finalItems = [];
    var length = items.length;
    for (int i = 0; i < length; i++) {
      int quantity = items[i].quantity.toInt();
      finalItems.add([
        (items[i].salesprice! * quantity).toString(),
        // items[i].discP.toString(),
        items[i].salesprice.toString(),
        // printType == 0 ? items[i].unitname : null ,
        quantity.toString(), // Use the integer quantity
        items[i].itmname ?? items[i].itmename ?? "None",
        printType == 0 ? items[i].itmcode : null ,

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

  var itemsList = getItems();
  final Document pdf = Document();
  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));
  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: printType == 0
          ? PdfPageFormat.a4
          : PdfPageFormat.roll80.copyWith(width: 5 * PdfPageFormat.cm),
      build: (Context context) {
        if (printType != 0) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 45.w,
                      height: 45.h,
                      child: Image(MemoryImage(imageData!))),
                  Container()
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  buildPDFText(AppConstants.branchName, fontSize: 14),
                ],
              ),
              Row(
                children: [
                  buildPDFText(invoiceType, fontSize: 9),
                ],
              ),
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
                          fontSize: 10.sp,
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
                    buildPDFText(invoTime ,fontSize: 8,),
                    buildPDFText('  الوقت :',fontSize: 8,),
                  ]),
                  buildPDFText(invoDate,fontSize: 8,),
                  buildPDFText('التاريخ :',fontSize: 8,),
                ],
              ),
              SizedBox(height: 8.h),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPDFText("الإجمالي", fontSize: 7),
                      SizedBox(width: 7.w),
                      buildPDFText("السعر", fontSize: 7),
                      SizedBox(width: 7.w),
                      buildPDFText("الكمية", fontSize: 7),
                      SizedBox(width: 15.w),
                      buildPDFText("الصنف", fontSize: 7),
                    ],
                  ),
                  ...itemsList.map((item) {
                    return Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(child: buildPDFText(item[0].toString(), fontSize: 7),width: 22.w),
                          SizedBox(width: 5.w),
                          SizedBox(child: buildPDFText(item[1].toString(), fontSize: 7),width: 22.w),
                          SizedBox(width: 5.w),
                          SizedBox(child: buildPDFText(item[2].toString(), fontSize: 7),width: 22.w),
                          // SizedBox(width: 5.w),
                          //buildPDFText(item[4].toString(), fontSize: 7),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: 35.w,
                              child: Text(
                                item[3].toString(),
                                style: TextStyle(fontSize: 7.sp),
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildDottedDivider()
                    ]);
                  }).toList(),
                  buildDottedDivider()
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPDFText(
                    "${SpellingNumber(lang: 'ar').convert(finalValue.floor())} ريال سعودى\n${SpellingNumber(lang: 'ar').convert(((finalValue - finalValue.floor()) * 100).round())} هلله فقط لا غير",
                    fontSize: 8,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              buildDottedDivider(),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPDFText(invNo.toString()),
                  buildPDFText(isReturn ? 'رقم المرتجع : ' : 'رقم الفاتورة : '),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BarcodeWidget(
                      data: qrData,
                      barcode: Barcode.qrCode(),
                      height: 100.h,
                      width: 120.w),
                ],
              ),
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
          ));
        } else {
          return Center(
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
                        buildPDFText(
                          AppConstants.branchName,
                        ),
                        buildPDFText(
                          AppConstants.taxNumber,
                        ),
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
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  buildPDFText('العميل : '),
                                ]),
                            fax != null ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildPDFText(fax),
                                  buildPDFText('الرقم الضريبي : '),
                                ]) : Container(),
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
                  width: 15 * PdfPageFormat.cm,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TableHelper.fromTextArray(
                      headerAlignment: Alignment.center,
                      columnWidths: {
                        0: const FixedColumnWidth(90),
                        1: const FixedColumnWidth(90),
                        // 2: const FixedColumnWidth(80),
                        3: const FixedColumnWidth(90),
                        4: const FixedColumnWidth(100),
                        5: const FixedColumnWidth(100),
                      },
                      headerStyle: TextStyle(fontSize: 5.sp),
                      headers: <dynamic>[
                        'الإجمالي',
                        'السعر',
                        // "الوحده",
                        'الكمية',
                        'الصنف',
                        'كود'
                      ],
                      cellAlignment: Alignment.center,
                      cellStyle: TextStyle(fontSize: 7.sp),
                      data: <List<dynamic>>[...itemsList],
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPDFText(netvalue.toStringAsFixed(2)),
                      buildPDFText(
                        'الإجمالي قبل الضريبة : ',
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPDFText(taxAdd.toStringAsFixed(2)),
                      buildPDFText(
                        'قيمة الضريبة : ',
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPDFText(finalValue.toStringAsFixed(2)),
                      buildPDFText("الإجمالي شامل الضريبة : "),
                    ]),
                buildPDFText(
                  "${SpellingNumber(lang: 'ar').convert(780)} ريال سعودى\n${SpellingNumber(lang: 'ar').convert(22)} هلله فقط لا غير",
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  buildPDFText(
                    AppConstants.notes,
                  ),
                ]),
              ],
            ),
          );
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

Directionality buildPDFText(String text, {double fontSize = 10}) {
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
  const double dashWidth = 24; // Increase dash width here
  const double dashSpace = 14; // Increase space between dashes here

  final numberOfDashes = (PdfPageFormat.a4.width / (dashWidth + dashSpace)).floor();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(numberOfDashes, (index) {
      return Container(
        width: dashWidth,
        height: 1,
        color: PdfColors.black,
        margin: const EdgeInsets.symmetric(horizontal: dashSpace / 2), // Adjust margin for better spacing
      );
    }),
  );
}
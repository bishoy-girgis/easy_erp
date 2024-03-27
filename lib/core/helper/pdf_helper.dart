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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // imagggeeee
                  Container(
                      width: 50.w,
                      height: 50.h,
                      child: Image(MemoryImage(imageData!))),
                  Column(
                    children: [
                      buildPDFText(AppConstants.branchName, fontSize: 20),
                      buildPDFText(AppConstants.taxNumber, fontSize: 20),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              buildPDFText(invoiceType, fontSize: 18),
              SizedBox(height: 8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                BarcodeWidget(
                    data: "$qrData",
                    barcode: Barcode.qrCode(),
                    height: 60.h,
                    width: 75.w),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    buildPDFText(invNo.toString()),
                    buildPDFText(
                        isReturn ? 'رقم المرتجع : ' : 'رقم الفاتورة : '),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    buildPDFText(custName),
                    buildPDFText('العميل : '),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    buildPDFText(invoDate),
                    buildPDFText('التاريخ : '),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(AppConstants.notes, fontSize: 15),
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
  getIt.get<InvoiceCubit>().removeInvoiceData();
}

Directionality buildPDFText(String text, {double fontSize = 18}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

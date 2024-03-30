import 'dart:io';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/app_images.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:spelling_number/spelling_number.dart';

Future<void> generatePdfReciept(
  context, {
  double? vatValue,
  required String pdfType,
  required String voucherNo,
  required String voucherDate,
  required String voucherTime,
  required double voucherValue,
  required String voucherNotes,
  required String payerName,
  required String voucherPaymentType,
}) async {
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
  final Document pdf = Document();
  var arabicFont = Font.ttf(
      await rootBundle.load("assets/fonts/Cairo/static/Cairo-Regular.ttf"));

  pdf.addPage(
    Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.letter,
      build: (context) {
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
              buildPDFText(pdfType, fontSize: 20),
              SizedBox(height: 20.h),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                buildPDFText(voucherNo.toString()),
                buildPDFText('الرقم السند : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                buildPDFText(voucherDate),
                buildPDFText('التاريخ : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                buildPDFText(voucherTime),
                buildPDFText('الوقت : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                buildPDFText(payerName),
                buildPDFText('اسم العميل : '),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                buildPDFText(voucherPaymentType),
                buildPDFText('طريقه الدفع : '),
              ]),
              SizedBox(height: 25.h),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(SpellingNumber(lang: 'ar').convert(voucherValue),
                    fontSize: 16),
                SizedBox(width: 5.w),
                buildPDFText(voucherValue.toStringAsFixed(2)),
                buildPDFText(
                  'المبلغ   : ',
                ),
              ]),
              (vatValue != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildPDFText(
                          SpellingNumber(lang: 'ar').convert(vatValue),
                          fontSize: 16,
                        ),
                        SizedBox(width: 5.w),
                        buildPDFText(vatValue.toStringAsFixed(2)),
                        buildPDFText(
                          'الضريبه   : ',
                        ),
                      ],
                    )
                  : Container(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildPDFText(voucherNotes),
                buildPDFText(
                  'الملاحطات   : ',
                ),
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

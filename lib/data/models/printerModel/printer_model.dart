import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf/pdf.dart';
part 'printer_model.g.dart';

@HiveType(typeId: 3)
class PrinterModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final PdfPageFormat format;

  PrinterModel({
    required this.name,
    required this.id,
    required this.format,
  });
}

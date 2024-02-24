// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrinterModelAdapter extends TypeAdapter<PrinterModel> {
  @override
  final int typeId = 3;

  @override
  PrinterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrinterModel(
      name: fields[1] as String,
      id: fields[0] as int,
      format: fields[2] as PdfPageFormat,
    );
  }

  @override
  void write(BinaryWriter writer, PrinterModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.format);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrinterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 0;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      custid: fields[0] as int?,
      custcode: fields[1] as int?,
      custname: fields[2] as String?,
      custename: fields[3] as String?,
      manager: fields[4] as String?,
      emanager: fields[5] as String?,
      fax: fields[6] as String?,
      address: fields[7] as String?,
      chartid: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.custid)
      ..writeByte(1)
      ..write(obj.custcode)
      ..writeByte(2)
      ..write(obj.custname)
      ..writeByte(3)
      ..write(obj.custename)
      ..writeByte(4)
      ..write(obj.manager)
      ..writeByte(5)
      ..write(obj.emanager)
      ..writeByte(6)
      ..write(obj.fax)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.chartid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

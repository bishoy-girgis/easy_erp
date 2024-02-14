// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      accessToken: fields[0] as String?,
      tokenType: fields[1] as String?,
      expiresIn: fields[2] as int?,
      userName: fields[3] as String?,
      branchId: fields[4] as int?,
      whId: fields[5] as int?,
      ccId: fields[6] as int?,
      discP: fields[7] as double?,
      empId: fields[8] as int?,
      companyId: fields[9] as int?,
      vatType: fields[10] as int?,
      vat: fields[11] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.tokenType)
      ..writeByte(2)
      ..write(obj.expiresIn)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.branchId)
      ..writeByte(5)
      ..write(obj.whId)
      ..writeByte(6)
      ..write(obj.ccId)
      ..writeByte(7)
      ..write(obj.discP)
      ..writeByte(8)
      ..write(obj.empId)
      ..writeByte(9)
      ..write(obj.companyId)
      ..writeByte(10)
      ..write(obj.vatType)
      ..writeByte(11)
      ..write(obj.vat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

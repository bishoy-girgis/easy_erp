// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 2;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      itmid: fields[0] as int?,
      subgrpid: fields[1] as int?,
      itmcode: fields[2] as String?,
      itmname: fields[3] as String?,
      itmename: fields[4] as String?,
      unitname: fields[5] as String?,
      unitid: fields[6] as int?,
      untItmIndx: fields[7] as int?,
      salesprice: fields[8] as double?,
      balance: fields[9] as int?,
      discP: fields[10] as double?,
      cost: fields[11] as double?,
      quantity: fields[12] as num,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.itmid)
      ..writeByte(1)
      ..write(obj.subgrpid)
      ..writeByte(2)
      ..write(obj.itmcode)
      ..writeByte(3)
      ..write(obj.itmname)
      ..writeByte(4)
      ..write(obj.itmename)
      ..writeByte(5)
      ..write(obj.unitname)
      ..writeByte(6)
      ..write(obj.unitid)
      ..writeByte(7)
      ..write(obj.untItmIndx)
      ..writeByte(8)
      ..write(obj.salesprice)
      ..writeByte(9)
      ..write(obj.balance)
      ..writeByte(10)
      ..write(obj.discP)
      ..writeByte(11)
      ..write(obj.cost)
      ..writeByte(12)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      itmid: json['itmid'] as int?,
      subgrpid: json['subgrpid'] as int?,
      itmcode: json['itmcode'] as String?,
      itmname: json['itmname'] as String?,
      itmename: json['itmename'] as String?,
      unitname: json['unitname'] as String?,
      unitid: json['unitid'] as int?,
      untItmIndx: json['UntItmIndx'] as int?,
      salesprice: (json['Salesprice'] as num?)?.toDouble(),
      balance: json['Balance'] as int?,
      discP: (json['DiscP'] as num?)?.toDouble(),
      cost: (json['Cost'] as num?)?.toDouble(),
      quantity: json['quantity'] as num? ?? 1,
    );
ItemModel _$ItemModelFromJsonToPrintInvoiceWithItems(
        Map<String, dynamic> json) =>
    // "Itemid": 1,
    //     "itmcode": "1111120001",
    //     "itmname": "شاي ",
    //     "itmename": "tea",
    //     "qty": 1.000,
    //     "price": 15.00,
    //     "discvalue": 0.00,
    //     "netvalue": 15.00
    ItemModel(
      itmid: json['Itemid'] as int?,
      itmcode: json['itmcode'] as String?,
      itmname: json['itmname'] as String?,
      itmename: json['itmename'] as String?,
      salesprice: (json['price'] as num?)?.toDouble(),
      discP: (json['discvalue'] as num?)?.toDouble(),
      cost: (json['netvalue'] as num?)?.toDouble(),
      quantity: json['qty'] as num? ?? 1,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      "itemid": instance.itmid,
      "Unitid": instance.unitid,
      "index": instance.untItmIndx,
      "Cost": instance.cost,
      "Qty": instance.quantity,
      "price": instance.salesprice,
      "Value": (instance.salesprice! * instance.quantity),
      "DiscVal": instance.salesprice! * (instance.discP! / 100),
      "NetValue": instance.salesprice! -
          (instance.salesprice! * (instance.discP! / 100)),
    };

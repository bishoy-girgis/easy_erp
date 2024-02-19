// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'item_model.dart';

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
      salesprice: json['Salesprice'],
      balance: json['Balance'] as int?,
      discP: json['DiscP'],
      cost: json['Cost'],
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

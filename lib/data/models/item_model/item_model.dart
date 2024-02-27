import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

///this line to enable Hive for this class
@HiveType(typeId: 2)
@JsonSerializable()
class ItemModel extends HiveObject {
  @HiveField(0)
  final int? itmid;
  @HiveField(1)
  final int? subgrpid;
  @HiveField(2)
  final String? itmcode;
  @HiveField(3)
  final String? itmname;
  @HiveField(4)
  final String? itmename;
  @HiveField(5)
  final String? unitname;
  @HiveField(6)
  final int? unitid;
  @HiveField(7)
  final int? untItmIndx;
  @HiveField(8)
  final double? salesprice;
  @HiveField(9)
  final int? balance;
  @HiveField(10)
  final double? discP;
  @HiveField(11)
  final double? cost;
  @HiveField(12)
  num quantity;

  ItemModel({
    this.itmid,
    this.subgrpid,
    this.itmcode,
    this.itmname,
    this.itmename,
    this.unitname,
    this.unitid,
    this.untItmIndx,
    this.salesprice,
    this.balance,
    this.discP,
    this.cost,
    this.quantity = 1,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  /// From Json  To Print Invoice

  factory ItemModel.fromJsonToPrintInvoiceWithItems(
          Map<String, dynamic> json) =>
      _$ItemModelFromJsonToPrintInvoiceWithItems(json);

  /// TO JSON
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  List<Object?> get props {
    return [
      itmid,
      subgrpid,
      itmcode,
      itmname,
      itmename,
      unitname,
      unitid,
      untItmIndx,
      salesprice,
      balance,
      discP,
    ];
  }
}
// factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
//       itmid: json['itmid'] as int?,
//       subgrpid: json['subgrpid'] as int?,
//       itmcode: json['itmcode'] as String?,
//       itmname: json['itmname'] as String?,
//       itmename: json['itmename'] as String?,
//       unitname: json['unitname'] as String?,
//       unitid: json['unitid'] as int?,
//       untItmIndx: json['UntItmIndx'] as int?,
//       salesprice: json['Salesprice'],
//       balance: json['Balance'] as int?,
//       discP: json['DiscP'],
//       cost: json['Cost'],
//       quantity: 1,
//     );

// Map<String, dynamic> toJson() => {
//       "itemid": itmid,
//       "Unitid": unitid,
//       "index": untItmIndx,
//       "Cost": cost,
//       "Qty": quantity,
//       "price": salesprice,
//       "Value": salesprice! * quantity,
//       "DiscVal": salesprice! * (discP! / 100),
//       "NetValue": salesprice! - (salesprice! * (discP! / 100))
//     };

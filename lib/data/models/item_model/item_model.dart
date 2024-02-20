import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends Equatable {
  final int? itmid;
  final int? subgrpid;
  final String? itmcode;
  final String? itmname;
  final String? itmename;
  final String? unitname;
  final int? unitid;
  final int? untItmIndx;
  final double? salesprice;
  final int? balance;
  final double? discP;
  final double? cost;
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

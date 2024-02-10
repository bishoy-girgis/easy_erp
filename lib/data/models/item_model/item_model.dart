import 'package:equatable/equatable.dart';

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

  const ItemModel({
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
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
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
      );

  Map<String, dynamic> toJson() => {
        'itmid': itmid,
        'subgrpid': subgrpid,
        'itmcode': itmcode,
        'itmname': itmname,
        'itmename': itmename,
        'unitname': unitname,
        'unitid': unitid,
        'UntItmIndx': untItmIndx,
        'Salesprice': salesprice,
        'Balance': balance,
        'DiscP': discP,
      };

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

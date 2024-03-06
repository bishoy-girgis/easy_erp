import 'package:equatable/equatable.dart';

class ReturnModel extends Equatable {
  final int? rtnInvid;
  final String? rtnInvNo;
  final String? rtnInvdate;
  final String? invtime;
  final String? custname;
  final int? rtnInvtype;
  final double? netvalue;
  final double? taxAdd;
  final double? finalValue;
  final int? invid;
  final String? invNo;
  final String? fax;

  const ReturnModel({
    this.rtnInvid,
    this.rtnInvNo,
    this.rtnInvdate,
    this.invtime,
    this.custname,
    this.rtnInvtype,
    this.netvalue,
    this.taxAdd,
    this.finalValue,
    this.invid,
    this.invNo,
    this.fax,
  });

  factory ReturnModel.fromJson(Map<String, dynamic> json) => ReturnModel(
        rtnInvid: json['RtnInvid'] as int?,
        rtnInvNo: json['RtnInvNo'] as String?,
        rtnInvdate: json['RtnInvdate'] as String?,
        invtime: json['invtime'] as String?,
        custname: json['custname'] as String?,
        rtnInvtype: json['RtnInvtype'] as int?,
        netvalue: (json['netvalue'] as num?)?.toDouble(),
        taxAdd: (json['TaxAdd'] as num?)?.toDouble(),
        finalValue: (json['FinalValue'] as num?)?.toDouble(),
        invid: json['Invid'] as int?,
        invNo: json['InvNo'] as String?,
        fax: json['fax'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'RtnInvid': rtnInvid,
        'RtnInvNo': rtnInvNo,
        'RtnInvdate': rtnInvdate,
        'invtime': invtime,
        'custname': custname,
        'RtnInvtype': rtnInvtype,
        'netvalue': netvalue,
        'TaxAdd': taxAdd,
        'FinalValue': finalValue,
        'Invid': invid,
        'InvNo': invNo,
        'fax': fax,
      };

  @override
  List<Object?> get props {
    return [
      rtnInvid,
      rtnInvNo,
      rtnInvdate,
      invtime,
      custname,
      rtnInvtype,
      netvalue,
      taxAdd,
      finalValue,
      invid,
      invNo,
      fax,
    ];
  }
}

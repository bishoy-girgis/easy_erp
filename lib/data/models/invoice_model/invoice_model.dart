import 'package:equatable/equatable.dart';

class InvoiceModel extends Equatable {
  final int? invid;
  final String? invNo;
  final String? invdate;
  final String? invtime;
  final String? custInvname;
  final dynamic invtype;
  final double? netvalue;
  final double? taxAdd;
  final double? finalValue;

  const InvoiceModel({
    this.invid,
    this.invNo,
    this.invdate,
    this.invtime,
    this.custInvname,
    this.invtype,
    this.netvalue,
    this.taxAdd,
    this.finalValue,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        invid: json['Invid'] as int?,
        invNo: json['InvNo'] as String?,
        invdate: json['invdate'] as String?,
        invtime: json['invtime'] as String?,
        custInvname: json['CustInvname'] as String?,
        invtype: json['invtype'] as dynamic,
        netvalue: json['netvalue'] as double?,
        taxAdd: json['TaxAdd'] as double?,
        finalValue: json['FinalValue'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'Invid': invid,
        'InvNo': invNo,
        'invdate': invdate,
        'invtime': invtime,
        'CustInvname': custInvname,
        'invtype': invtype,
        'netvalue': netvalue,
        'TaxAdd': taxAdd,
        'FinalValue': finalValue,
      };

  @override
  List<Object?> get props {
    return [
      invid,
      invNo,
      invdate,
      invtime,
      custInvname,
      invtype,
      netvalue,
      taxAdd,
      finalValue,
    ];
  }
}

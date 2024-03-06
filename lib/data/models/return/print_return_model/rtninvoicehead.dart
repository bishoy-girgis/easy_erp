import 'package:equatable/equatable.dart';

class Rtninvoicehead extends Equatable {
  final int? rtnInvid;
  final String? rtnInvNo;
  final String? einvtype;
  final String? rtnInvtype;
  final String? custname;
  final String? fax;
  final String? branchname;
  final double? netvalue;
  final double? taxAdd;
  final double? finalValue;
  final String? payname;
  final String? payename;
  final String? rtnInvdate;
  final String? invtime;
  final String? companyname;
  final String? vat;
  final int? invid;

  const Rtninvoicehead({
    this.rtnInvid,
    this.rtnInvNo,
    this.einvtype,
    this.rtnInvtype,
    this.custname,
    this.fax,
    this.branchname,
    this.netvalue,
    this.taxAdd,
    this.finalValue,
    this.payname,
    this.payename,
    this.rtnInvdate,
    this.invtime,
    this.companyname,
    this.vat,
    this.invid,
  });

  factory Rtninvoicehead.fromJson(Map<String, dynamic> json) {
    return Rtninvoicehead(
      rtnInvid: json['RtnInvid'] as int?,
      rtnInvNo: json['RtnInvNo'] as String?,
      einvtype: json['Einvtype'] as String?,
      rtnInvtype: json['RtnInvtype'] as String?,
      custname: json['custname'] as String?,
      fax: json['fax'] as String?,
      branchname: json['branchname'] as String?,
      netvalue: (json['netvalue'] as num?)?.toDouble(),
      taxAdd: (json['TaxAdd'] as num?)?.toDouble(),
      finalValue: (json['FinalValue'] as num?)?.toDouble(),
      payname: json['payname'] as String?,
      payename: json['payename'] as String?,
      rtnInvdate: json['RtnInvdate'] as String?,
      invtime: json['invtime'] as String?,
      companyname: json['companyname'] as String?,
      vat: json['VAT'] as String?,
      invid: json['Invid'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'RtnInvid': rtnInvid,
        'RtnInvNo': rtnInvNo,
        'Einvtype': einvtype,
        'RtnInvtype': rtnInvtype,
        'custname': custname,
        'fax': fax,
        'branchname': branchname,
        'netvalue': netvalue,
        'TaxAdd': taxAdd,
        'FinalValue': finalValue,
        'payname': payname,
        'payename': payename,
        'RtnInvdate': rtnInvdate,
        'invtime': invtime,
        'companyname': companyname,
        'VAT': vat,
        'Invid': invid,
      };

  @override
  List<Object?> get props {
    return [
      rtnInvid,
      rtnInvNo,
      einvtype,
      rtnInvtype,
      custname,
      fax,
      branchname,
      netvalue,
      taxAdd,
      finalValue,
      payname,
      payename,
      rtnInvdate,
      invtime,
      companyname,
      vat,
      invid,
    ];
  }
}

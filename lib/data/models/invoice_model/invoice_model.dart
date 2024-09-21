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
  final String? CompanyName;
  final String? vat;
  final String? fax;

  final String? qr;

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
    this.CompanyName,
    this.fax,
    this.vat,
    this.qr,
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
        CompanyName: json['companyname'] as String?,
        vat: json['VAT'] as String?,
        fax: json['fax'] as String?,
        qr: json['QR'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Invid': invid,
        'fax': fax,
        'InvNo': invNo,
        'invdate': invdate,
        'invtime': invtime,
        'CustInvname': custInvname,
        'invtype': invtype,
        'netvalue': netvalue,
        'TaxAdd': taxAdd,
        'FinalValue': finalValue,
        'companyname': CompanyName,
        'VAT': vat,
        'QR': qr,
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
      CompanyName,
      vat,
      fax,
      qr,
    ];
  }
}

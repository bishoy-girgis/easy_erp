import 'package:equatable/equatable.dart';

class RecieptModel extends Equatable {
  final int? cashinhdrId;
  final int? cashinOrdno;
  final String? date;
  final int? branchid;
  final int? ccid;
  final int? custchartid;
  final String? custchartName;
  final String? user;
  final double? recvalue;
  final int? payid;
  final String? payName;
  final int? bankDtlId;

  const RecieptModel({
    this.cashinhdrId,
    this.cashinOrdno,
    this.date,
    this.branchid,
    this.ccid,
    this.custchartid,
    this.custchartName,
    this.user,
    this.recvalue,
    this.payid,
    this.payName,
    this.bankDtlId,
  });

  factory RecieptModel.fromJson(Map<String, dynamic> json) => RecieptModel(
        cashinhdrId: json['cashinhdr_id'] as int?,
        cashinOrdno: json['cashin_ordno'] as int?,
        date: json['date'] as String?,
        branchid: json['branchid'] as int?,
        ccid: json['ccid'] as int?,
        custchartid: json['custchartid'] as int?,
        custchartName: json['custchartName'] as String?,
        user: json['user'] as String?,
        recvalue: json['recvalue'] as double?,
        payid: json['Payid'] as int?,
        payName: json['PayName'] as String?,
        bankDtlId: json['bankDtlId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'cashinhdr_id': cashinhdrId,
        'cashin_ordno': cashinOrdno,
        'date': date,
        'branchid': branchid,
        'ccid': ccid,
        'custchartid': custchartid,
        'custchartName': custchartName,
        'user': user,
        'recvalue': recvalue,
        'Payid': payid,
        'PayName': payName,
        'bankDtlId': bankDtlId,
      };

  @override
  List<Object?> get props {
    return [
      cashinhdrId,
      cashinOrdno,
      date,
      branchid,
      ccid,
      custchartid,
      custchartName,
      user,
      recvalue,
      payid,
      payName,
      bankDtlId,
    ];
  }
}

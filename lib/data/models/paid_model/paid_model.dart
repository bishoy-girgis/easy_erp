import 'package:equatable/equatable.dart';

class PaidModel extends Equatable {
  final int? cashoutHdrid;
  final int? cashoutOrdno;
  final String? date;
  final int? branchid;
  final int? ccid;
  final int? fromchartId;
  final String? paymentchartName;
  final String? user;
  final double? payvalue;
  final double? vatvalue;
  final int? payid;
  final String? payName;
  final int? bankDtlId;
  final String? notes;

  const PaidModel({
    this.cashoutHdrid,
    this.cashoutOrdno,
    this.date,
    this.branchid,
    this.ccid,
    this.fromchartId,
    this.paymentchartName,
    this.user,
    this.payvalue,
    this.vatvalue,
    this.payid,
    this.payName,
    this.bankDtlId,
    this.notes,
  });

  factory PaidModel.fromJson(Map<String, dynamic> json) => PaidModel(
        cashoutHdrid: json['cashout_hdrid'] as int?,
        cashoutOrdno: json['cashout_ordno'] as int?,
        date: json['date'] as String?,
        branchid: json['branchid'] as int?,
        ccid: json['ccid'] as int?,
        fromchartId: json['fromchart_id'] as int?,
        paymentchartName: json['paymentchartName'] as String?,
        user: json['user'] as String?,
        payvalue: json['payvalue'] as double?,
        vatvalue: json['vatvalue'] as double?,
        payid: json['Payid'] as int?,
        payName: json['PayName'] as String?,
        bankDtlId: json['bankDtlId'] as int?,
        notes: json['Notes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'cashout_hdrid': cashoutHdrid,
        'cashout_ordno': cashoutOrdno,
        'date': date,
        'branchid': branchid,
        'ccid': ccid,
        'fromchart_id': fromchartId,
        'paymentchartName': paymentchartName,
        'user': user,
        'payvalue': payvalue,
        'vatvalue': vatvalue,
        'Payid': payid,
        'PayName': payName,
        'bankDtlId': bankDtlId,
        'Notes': notes,
      };

  @override
  List<Object?> get props {
    return [
      cashoutHdrid,
      cashoutOrdno,
      date,
      branchid,
      ccid,
      fromchartId,
      paymentchartName,
      user,
      payvalue,
      vatvalue,
      payid,
      payName,
      bankDtlId,
      notes,
    ];
  }
}

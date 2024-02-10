import 'package:equatable/equatable.dart';

class PaymentTypeModel extends Equatable {
  final int? payid;
  final String? payname;
  final String? payename;
  final int? bankdtlId;

  const PaymentTypeModel({
    this.payid,
    this.payname,
    this.payename,
    this.bankdtlId,
  });

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) {
    return PaymentTypeModel(
      payid: json['payid'] as int?,
      payname: json['payname'] as String?,
      payename: json['payename'] as String?,
      bankdtlId: json['bankdtl_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'payid': payid,
        'payname': payname,
        'payename': payename,
        'bankdtl_id': bankdtlId,
      };

  @override
  List<Object?> get props => [payid, payname, payename, bankdtlId];
}

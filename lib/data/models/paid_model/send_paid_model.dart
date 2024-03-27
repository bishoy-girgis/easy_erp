import 'package:equatable/equatable.dart';

class SendPaidModel extends Equatable {
  final String? massage;
  final int? payNo;
  final int? payId;

  const SendPaidModel({this.massage, this.payNo, this.payId});

  factory SendPaidModel.fromJson(Map<String, dynamic> json) => SendPaidModel(
        massage: json['massage'] as String?,
        payNo: json['pay_no'] as int?,
        payId: json['pay_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'massage': massage,
        'pay_no': payNo,
        'pay_id': payId,
      };

  @override
  List<Object?> get props => [massage, payNo, payId];
}

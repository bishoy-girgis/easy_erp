import 'package:equatable/equatable.dart';

class SendInvoiceModel extends Equatable {
  final String? massage;
  final int? invno;

  const SendInvoiceModel({this.massage, this.invno});

  factory SendInvoiceModel.fromJson(dynamic json) {
    return SendInvoiceModel(
      massage: json['massage'],
      invno: json['invno'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'massage': massage,
        'customercode': invno,
      };

  @override
  List<Object?> get props => [massage, invno];
}

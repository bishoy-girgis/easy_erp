import 'package:equatable/equatable.dart';

class SendInvoiceModel extends Equatable {
  final String? massage;
  final int? invno;
  final String? qr;

  const SendInvoiceModel({this.massage, this.invno, this.qr});

  factory SendInvoiceModel.fromJson(Map<String, dynamic> json) {
    return SendInvoiceModel(
      massage: json['massage'] as String?,
      invno: json['invno'] as int?,
      qr: json['QR'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'massage': massage,
        'customercode': invno,
        'QR': qr,
      };

  @override
  List<Object?> get props => [massage, invno, qr];
}

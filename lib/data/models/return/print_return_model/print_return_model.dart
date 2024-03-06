import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'rtninvoicehead.dart';

class PrintReturnModel extends Equatable {
  final List<Rtninvoicehead>? rtninvoicehead;
  final List<ItemModel>? rtninvoicedtls;
  final dynamic errormessage;
  final String? qr;

  const PrintReturnModel({
    this.rtninvoicehead,
    this.rtninvoicedtls,
    this.errormessage,
    this.qr,
  });

  factory PrintReturnModel.fromJson(Map<String, dynamic> json) {
    return PrintReturnModel(
      rtninvoicehead: (json['Rtninvoicehead'] as List<dynamic>?)
          ?.map((e) => Rtninvoicehead.fromJson(e as Map<String, dynamic>))
          .toList(),
      rtninvoicedtls: (json['Rtninvoicedtls'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJsonToPrintInvoiceWithItems(
              e as Map<String, dynamic>))
          .toList(),
      errormessage: json['errormessage'] as dynamic,
      qr: json['QR'] as String?,
    );
  }

  @override
  List<Object?> get props {
    return [
      rtninvoicehead,
      rtninvoicedtls,
      errormessage,
      qr,
    ];
  }
}

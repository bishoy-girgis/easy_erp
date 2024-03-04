import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:equatable/equatable.dart';

import '../invoice_model/invoice_model.dart';

class PrintInvoiceModel extends Equatable {
  final List<InvoiceModel>? invoicehead;
  final List<ItemModel>? invoicedtls;
  final String? qr;

  const PrintInvoiceModel({this.invoicehead, this.invoicedtls, this.qr});

  factory PrintInvoiceModel.fromJson(Map<String, dynamic> json) {
    return PrintInvoiceModel(
      invoicehead: (json['invoicehead'] as List<dynamic>?)
          ?.map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoicedtls: (json['invoicedtls'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJsonToPrintInvoiceWithItems(
              e as Map<String, dynamic>))
          .toList(),
      qr: json['QR'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'invoicehead': invoicehead?.map((e) => e.toJson()).toList(),
        'invoicedtls': invoicedtls?.map((e) => e.toJson()).toList(),
        'QR': qr,
      };

  @override
  List<Object?> get props => [invoicehead, invoicedtls, qr];
}

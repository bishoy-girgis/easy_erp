import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:equatable/equatable.dart';

import '../../invoice_model/invoice_model.dart';

class PrintInvoiceModel extends Equatable {
  final List<InvoiceModel>? invoicehead;
  final List<ItemModel>? invoicedtls;

  const PrintInvoiceModel({this.invoicehead, this.invoicedtls});

  factory PrintInvoiceModel.fromJson(Map<String, dynamic> json) {
    return PrintInvoiceModel(
      invoicehead: (json['invoicehead'] as List<dynamic>?)
          ?.map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoicedtls: (json['invoicedtls'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'invoicehead': invoicehead?.map((e) => e.toJson()).toList(),
        'invoicedtls': invoicedtls?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [invoicehead, invoicedtls];
}

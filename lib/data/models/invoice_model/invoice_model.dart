import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';

class InvoiceModel {
  final DateTime? date;
  final int? custid;
  final int? invtype;
  final String? user;
  final int? whid;
  final int? ccid;
  final int? branchid;
  final double? netvalue;
  final double? taxAdd;
  final double? finalValue;
  final int? payid;
  final int? bankDtlId;
  final List<ItemModel>? items;
  InvoiceModel({
    this.date,
    this.custid,
    this.invtype,
    this.user,
    this.whid,
    this.ccid,
    this.branchid,
    this.netvalue,
    this.taxAdd,
    this.finalValue,
    this.payid,
    this.bankDtlId,
    this.items,
  });
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      date: DateTime.parse(json['date']),
      custid: json['custid'],
      invtype: json['invtype'],
      user: json['user'],
      whid: json['whid'],
      ccid: json['ccid'],
      branchid: json['branchid'],
      netvalue: json['netvalue'],
      taxAdd: json['taxAdd'],
      finalValue: json['finalValue'],
      payid: json['payid'],
      bankDtlId: json['bankDtlId'],
      items: (json['items'] as List<dynamic>?)
          ?.map((itemJson) => ItemModel.fromJson(itemJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'custid': custid,
      'invtype': invtype,
      'user': user,
      'whid': whid,
      'ccid': ccid,
      'branchid': branchid,
      'netvalue': netvalue,
      'taxAdd': taxAdd,
      'finalValue': finalValue,
      'payid': payid,
      'bankDtlId': bankDtlId,
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }

  double totalCost() {
    return items!.fold(
        0, (previousValue, element) => previousValue + element.salesprice!);
  }
}

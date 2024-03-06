import 'package:equatable/equatable.dart';

class Rtninvoicedtl extends Equatable {
  final int? itemid;
  final String? itmcode;
  final String? itmname;
  final String? itmename;
  final int? qty;
  final int? price;
  final int? discvalue;
  final int? netvalue;

  const Rtninvoicedtl({
    this.itemid,
    this.itmcode,
    this.itmname,
    this.itmename,
    this.qty,
    this.price,
    this.discvalue,
    this.netvalue,
  });

  factory Rtninvoicedtl.fromJson(Map<String, dynamic> json) => Rtninvoicedtl(
        itemid: json['Itemid'] as int?,
        itmcode: json['itmcode'] as String?,
        itmname: json['itmname'] as String?,
        itmename: json['itmename'] as String?,
        qty: json['qty'] as int?,
        price: json['price'] as int?,
        discvalue: json['discvalue'] as int?,
        netvalue: json['netvalue'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Itemid': itemid,
        'itmcode': itmcode,
        'itmname': itmname,
        'itmename': itmename,
        'qty': qty,
        'price': price,
        'discvalue': discvalue,
        'netvalue': netvalue,
      };

  @override
  List<Object?> get props {
    return [
      itemid,
      itmcode,
      itmname,
      itmename,
      qty,
      price,
      discvalue,
      netvalue,
    ];
  }
}

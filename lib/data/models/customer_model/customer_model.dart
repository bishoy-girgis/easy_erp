import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int? custid;
  final int? custcode;
  final dynamic custname;
  final String? custename;
  final String? manager;
  final String? emanager;
  final String? fax;
  final String? address;
  final int? chartid;

  const CustomerModel({
    this.custid,
    this.custcode,
    this.custname,
    this.custename,
    this.manager,
    this.emanager,
    this.fax,
    this.address,
    this.chartid,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        custid: json['custid'] as int?,
        custcode: json['custcode'] as int?,
        custname: json['custname'] as dynamic,
        custename: json['custename'] as String?,
        manager: json['manager'] as String?,
        emanager: json['emanager'] as String?,
        fax: json['fax'] as String?,
        address: json['address'] as String?,
        chartid: json['chartid'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'custid': custid,
        'custcode': custcode,
        'custname': custname,
        'custename': custename,
        'manager': manager,
        'emanager': emanager,
        'fax': fax,
        'address': address,
        'chartid': chartid,
      };

  @override
  List<Object?> get props {
    return [
      custid,
      custcode,
      custname,
      custename,
      manager,
      emanager,
      fax,
      address,
      chartid,
    ];
  }
}

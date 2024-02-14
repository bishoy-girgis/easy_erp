import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 0)
class CustomerModel extends Equatable {
  @HiveField(0)
  final int? custid;
  @HiveField(1)
  final int? custcode;
  @HiveField(2)
  final String? custname;
  @HiveField(3)
  final String? custename;
  @HiveField(4)
  final String? manager;
  @HiveField(5)
  final String? emanager;
  @HiveField(6)
  final String? fax;
  @HiveField(7)
  final String? address;
  @HiveField(8)
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
        custname: json['custname'],
        custename: json['custename'],
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

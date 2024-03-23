import 'package:equatable/equatable.dart';

class PayerTypeModel extends Equatable {
  final int? chartid;
  final String? chartCode;
  final String? accname;
  final String? accename;

  const PayerTypeModel(
      {this.chartid, this.chartCode, this.accname, this.accename});

  factory PayerTypeModel.fromJson(Map<String, dynamic> json) => PayerTypeModel(
        chartid: json['Chartid'] as int?,
        chartCode: json['ChartCode'] as String?,
        accname: json['accname'] as String?,
        accename: json['accename'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Chartid': chartid,
        'ChartCode': chartCode,
        'accname': accname,
        'accename': accename,
      };

  @override
  List<Object?> get props => [chartid, chartCode, accname, accename];
}

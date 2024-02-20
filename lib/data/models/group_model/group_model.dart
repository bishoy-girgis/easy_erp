import 'package:equatable/equatable.dart';

class GroupModel extends Equatable {
  final int? custCategoryId;
  final String? custCategoryName;
  final String? custCategoryEname;

  const GroupModel({
    this.custCategoryId,
    this.custCategoryName,
    this.custCategoryEname,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        custCategoryId: json['CustCategoryID'] as int?,
        custCategoryName: json['CustCategoryName'] as String?,
        custCategoryEname: json['CustCategoryEname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'CustCategoryID': custCategoryId,
        'CustCategoryName': custCategoryName,
        'CustCategoryEname': custCategoryEname,
      };

  @override
  List<Object?> get props {
    return [
      custCategoryId,
      custCategoryName,
      custCategoryEname,
    ];
  }
}

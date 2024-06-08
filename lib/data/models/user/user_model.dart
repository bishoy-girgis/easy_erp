import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart'; // This will be generated by the build_runner

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String? accessToken;
  @HiveField(1)
  final String? tokenType;
  @HiveField(2)
  final int? expiresIn;
  @HiveField(3)
  final String? userName;
  @HiveField(4)
  final int? branchId;
  @HiveField(5)
  final int? whId;
  @HiveField(6)
  final int? ccId;
  @HiveField(7)
  final double? discP;
  @HiveField(8)
  final int? empId;
  @HiveField(9)
  final int? companyId;
  @HiveField(10)
  final int? vatType;
  @HiveField(11)
  final double? vat;
  final bool? changePrice;

  const UserModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.userName,
    this.branchId,
    this.whId,
    this.ccId,
    this.discP,
    this.empId,
    this.companyId,
    this.vatType,
    this.vat,
    this.changePrice,
  });

  factory UserModel.fromJson(dynamic json) => UserModel(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        userName: json['UserName'],
        branchId: json['BranchId'],
        whId: json['whId'],
        ccId: json['CCId'],
        discP: json['DiscP'],
        empId: json['EmpId'],
        companyId: json['CompanyId'],
        vatType: json['VATType'],
        vat: json['VAT'],
        changePrice: json['CHANGEPRICE'],
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'UserName': userName,
        'BranchId': branchId,
        'whId': whId,
        'CCId': ccId,
        'DiscP': discP,
        'EmpId': empId,
        'CompanyId': companyId,
        'VATType': vatType,
        'VAT': vat,
        'CHANGEPRICE': changePrice,
      };

  @override
  List<Object?> get props {
    return [
      accessToken,
      tokenType,
      expiresIn,
      userName,
      branchId,
      whId,
      ccId,
      discP,
      empId,
      companyId,
      vatType,
      vat,
      changePrice
    ];
  }
}

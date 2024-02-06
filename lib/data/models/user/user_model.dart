import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? userName;
  final int? branchId;
  final int? whId;
  final int? ccId;
  final double? discP;
  final int? empId;
  final int? companyId;
  final int? vatType;
  final double? vat;

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
    ];
  }
}

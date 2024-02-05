import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? userName;
  final int? branchId;
  final int? whId;
  final int? ccId;
  final int? discP;
  final int? empId;
  final int? companyId;
  final int? vatType;
  final int? vat;

  const User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json['access_token'] as String?,
        tokenType: json['token_type'] as String?,
        expiresIn: json['expires_in'] as int?,
        userName: json['UserName'] as String?,
        branchId: json['BranchId'] as int?,
        whId: json['whId'] as int?,
        ccId: json['CCId'] as int?,
        discP: json['DiscP'] as int?,
        empId: json['EmpId'] as int?,
        companyId: json['CompanyId'] as int?,
        vatType: json['VATType'] as int?,
        vat: json['VAT'] as int?,
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

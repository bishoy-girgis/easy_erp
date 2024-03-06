import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/return/print_return_model/print_return_model.dart';
import 'package:easy_erp/data/models/return/return_model.dart';
import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo.dart';
import 'package:flutter/material.dart';

class ReturnRepoImplementation extends ReturnRepo {
  ApiService apiService;
  ReturnRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, SendInvoiceModel>> saveReturn({
    required DateTime date,
    required int? custid,
    required int? invtype,
    required String user,
    required int whid,
    required int? ccid,
    required int? branchid,
    required double? netvalue,
    required double? taxAdd,
    required double? finalValue,
    required int? payid,
    required int? bankDtlId,
    int? invid,
    required List<ItemModel> items,
  }) async {
    print("LIST OF ITEMS  === > ${items.map((e) => e.toJson()).toList()} \n");
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();

    try {
      Map<String, dynamic> data = await apiService.postBody(
        data: itemsJson,
        endPoint: AppConstants.POST_Return,
        queryParameters: {
          'date': date,
          'custid': custid,
          'invtype': invtype,
          'user': user,
          'whid': whid,
          'ccid': ccid,
          'branchid': branchid,
          'netvalue': netvalue,
          'TaxAdd': taxAdd,
          'FinalValue': finalValue,
          'Payid': payid,
          'bankDtlId': bankDtlId,
          'invid': invid ?? 0,
        },
      );
      print('DATATA IN return REPO' + data.toString());
      SendInvoiceModel sendInvoiceModel = SendInvoiceModel.fromJson(data);
      return right(sendInvoiceModel);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        print(e.toString());
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, List<ReturnModel>>> getReturns() async {
    try {
      debugPrint("DATA IN Return REPO IMP ✨✨");
      var data = await apiService.get(
          endPoint: AppConstants.GET_Returns,
          queryParameters: {
            'Branchid': AppConstants.branchID,
            'username': AppConstants.userName
          });

      List<ReturnModel> returns = [];
      for (var customer in data) {
        returns.add(ReturnModel.fromJson(customer));
      }
      return right(returns);
    } catch (e) {
      if (e is DioException) {
        debugPrint(
            "${e.response}  ,,,,,,,,,,,,,, ${e.message} ,,,,,,,,,,,,,,,  ${e.error}");
        return left(ServerError.fromDioError(e));
      } else {
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failures, PrintReturnModel>> getReturnDataAndItems(
      {required String returnInvNo}) async {
    try {
      debugPrint("DATA IN Return REPO IMP ✨✨");
      var data = await apiService.get(
        endPoint: AppConstants.PRINT_Return_WITH_ITEMS,
        queryParameters: {
          'RTNInvNo': returnInvNo,
        },
      );
      PrintReturnModel printReturnModel = PrintReturnModel.fromJson(data);
      debugPrint(printReturnModel.toString());
      return right(printReturnModel);
    } catch (e) {
      if (e is DioException) {
        debugPrint(
            "${e.response},,,,,,,,,,,,,, ${e.message},,,,,,,,,,,,,,,  ${e.error}");
        return left(ServerError.fromDioError(e));
      } else {
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_model.dart';
import 'package:easy_erp/data/models/reciept/send_return_model/send_reciept_model.dart';
import 'package:easy_erp/data/repositories/reciept_repository/reciept_repo.dart';
import 'package:flutter/material.dart';

class RecieptRepoImplementation extends RecieptRepo {
  ApiService apiService;
  RecieptRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, SendRecieptModel>> saveReciept({
    required DateTime date,
    required String user,
    required int? ccid,
    required int? branchid,
    required int? payid,
    required int? bankDtlId,
    required int? custchartid,
    required double? recvalue,
  }) async {
    try {
      Map<String, dynamic> data = await apiService.postBody(
        endPoint: AppConstants.POST_Reciept,
        queryParameters: {
          'date': date,
          'user': user,
          'ccid': ccid,
          'branchid': branchid,
          'Payid': payid,
          'bankDtlId': bankDtlId,
          'custchartid': custchartid,
          'recvalue': recvalue,
        },
      );
      print('DATAA IN RECIEEPRTT REPO');
      SendRecieptModel sendRecieptModel = SendRecieptModel.fromJson(data);
      return right(sendRecieptModel);
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
  Future<Either<Failures, List<RecieptModel>>> getReciepts() async {
    try {
      debugPrint("DATA IN Reciept REPO IMP ✨✨");
      var data = await apiService.get(
          endPoint: AppConstants.GET_Reciepts,
          queryParameters: {
            'Branchid': AppConstants.branchID,
            'username': AppConstants.userName
          });

      List<RecieptModel> reciepts = [];
      for (var customer in data) {
        reciepts.add(RecieptModel.fromJson(customer));
      }
      return right(reciepts);
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
}

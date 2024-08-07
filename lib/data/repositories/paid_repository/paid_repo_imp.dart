import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/paid_model/paid_model.dart';
import 'package:easy_erp/data/models/paid_model/send_paid_model.dart';
import 'package:easy_erp/data/repositories/paid_repository/paid_repo.dart';
import 'package:flutter/material.dart';

class PaidRepoImplementation extends PaidRepo {
  ApiService apiService;
  PaidRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, List<PaidModel>>> getPaids() async {
    try {
      debugPrint("DATA IN Paid REPO IMP ✨✨");
      var data = await apiService.get(
          endPoint: AppConstants.GET_Paids,
          queryParameters: {
            'Branchid': AppConstants.branchID,
            'username': AppConstants.userName
          });

      List<PaidModel> paids = [];
      for (var paid in data) {
        paids.add(PaidModel.fromJson(paid));
      }
      return right(paids);
    } catch (e) {
      if (e is DioException) {
        debugPrint(
            "${e.response}  ,,,,,,,,,,,,,, ${e.error.toString()} ");
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
  Future<Either<Failures, SendPaidModel>> savepaid({
    required DateTime date,
    required String user,
    required int? ccid,
    required int? branchid,
    required int? payid,
    required int? bankDtlId,
    required int? paymentchartid,
    required double? payvalue,
    required double? vatvalue,
    required String notes,
  }) async {
    try {
      Map<String, dynamic> data = await apiService.postBody(
        endPoint: AppConstants.POST_Paid,
        queryParameters: {
          'date': date,
          'user': user,
          'ccid': ccid,
          'branchid': branchid,
          'Payid': payid,
          'bankDtlId': bankDtlId,
          'paymentchartid': paymentchartid,
          'payvalue': payvalue,
          'vatvalue': vatvalue,
          'Notes': notes,
          'pay_no': 0,
          'pay_id': 0
        },
      );
      debugPrint('DATAA IN PAiDD REPO');
      SendPaidModel sendPaidModel = SendPaidModel.fromJson(data);
      return right(sendPaidModel);
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        debugPrint(e.toString());
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}

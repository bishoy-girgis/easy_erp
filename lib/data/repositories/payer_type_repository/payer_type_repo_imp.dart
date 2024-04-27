import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';
import 'package:easy_erp/data/repositories/payer_type_repository/payer_type_repo.dart';
import 'package:flutter/cupertino.dart';

class PayerTypeRepoImp extends PayerTypeRepo {
  ApiService apiService;
  PayerTypeRepoImp({
    required this.apiService,
  });
  @override
  Future<Either<Failures, List<PayerTypeModel>>> getPayerType(
      {required int type}) async {
    try {
      debugPrint("DATA IN Payer Type REPO IMP ✨✨");
      var data = await apiService.get(
          endPoint: AppConstants.GET_PAYER_TYPE,
          queryParameters: {"type": type});

      List<PayerTypeModel> payerType = [];
      for (var item in data) {
        payerType.add(PayerTypeModel.fromJson(item));
      }
      return right(payerType);
    } catch (e) {
      if (e is DioException) {
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

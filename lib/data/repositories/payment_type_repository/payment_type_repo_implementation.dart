// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/payment_type_model/pay_ment_type_model.dart';
import 'package:easy_erp/data/repositories/payment_type_repository/payment_type_repo.dart';

import '../../../core/helper/app_constants.dart';

class PaymentTypeRepoImp extends PaymentTypeRepo {
  ApiService apiService;
  PaymentTypeRepoImp({
    required this.apiService,
  });
  @override
  Future<Either<Failures, List<PaymentTypeModel>>> getPaymentTypes() async {
    try {
      print("DATA IN Customer REPO IMP ✨✨");
      var data = await apiService.get(
        endPoint: AppConstants.GET_PAYMENT_TYPE,
      );

      List<PaymentTypeModel> payTypes = [];
      for (var item in data) {
        payTypes.add(PaymentTypeModel.fromJson(item));
      }
      return right(payTypes);
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

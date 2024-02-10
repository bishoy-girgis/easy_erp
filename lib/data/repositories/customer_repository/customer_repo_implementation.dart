// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';

import '../../../core/api_services/api_service.dart';
import '../../../core/helper/app_constants.dart';

class CustomerRepoImplementation extends CustomerRepo {
  ApiService apiService;
  CustomerRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, List<CustomerModel>>> getCustomers() async {
    try {
      print("DATA IN Customer REPO IMP ✨✨");
      var data = await apiService.get(
        endPoint: AppConstants.GET_CUSTOMERS,
      );

      List<CustomerModel> customers = [];
      for (var customer in data) {
        customers.add(CustomerModel.fromJson(customer));
      }
      return right(customers);
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
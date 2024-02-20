// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/add_customer_response_model/add_customer_response_model.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/group_model/group_model.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';

import '../../../core/api/api_service.dart';
import '../../../core/helper/app_constants.dart';

class CustomerRepoImplementation extends CustomerRepo {
  ApiService apiService;
  CustomerRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, List<CustomerModel>>> getCustomers() async {
    try {
      print("DATA IN Customer REPO IMP ✨getCustomers✨");
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

  @override
  Future<Either<Failures, List<GroupModel>>> getGroups() async {
    try {
      print("DATA IN Customer REPO IMP ✨getGroups✨");
      var data = await apiService.get(
        endPoint: AppConstants.GET_CUSTOMER_GROUPS,
      );

      List<GroupModel> groups = [];
      for (var item in data) {
        groups.add(GroupModel.fromJson(item));
      }
      return right(groups);
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

  @override
  Future<Either<Failures, AddCustomerResponseModel>> addCustomer({
    required String custNameAr,
    required String custNameEn,
    required String fax,
    required String mobileNumber,
    required String addressAr,
    required String addressEn,
    required String mangNameAr,
    required String mangNameEn,
    required int groupID,
  }) async {
    try {
      print("DATA IN Customer REPO IMP ✨getGroups✨");
      var data = await apiService.postBody(
        endPoint: AppConstants.POST_CUSTOMER,
        queryParameters: {
          'custname': custNameAr,
          'custename': custNameEn,
          'fax': fax,
          'Mobile': mobileNumber,
          'address': addressAr,
          'eaddress': addressEn,
          'manager': mangNameAr,
          'emanager': mangNameEn,
          'CustCategoryID': groupID,
        },
      );
      AddCustomerResponseModel addCustomerResponseModel =
          AddCustomerResponseModel.fromJson(data);
      return right(addCustomerResponseModel);
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

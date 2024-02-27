import 'package:dartz/dartz.dart';
import 'package:easy_erp/data/models/add_customer_response_model/add_customer_response_model.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/group_model/group_model.dart';

import '../../../core/errors/failures.dart';

abstract class CustomerRepo {
  Future<Either<Failures, List<CustomerModel>>> getCustomers();
  Future<Either<Failures, List<GroupModel>>> getGroups();
  Future<Either<Failures, AddCustomerResponseModel>> addCustomer({
    required String custNameAr,
    String custNameEn,
    String fax,
    String mobileNumber,
    String addressAr,
    String addressEn,
    String mangNameAr,
    String mangNameEn,
    required int groupID,
  });
}

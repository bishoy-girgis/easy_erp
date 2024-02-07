import 'package:dartz/dartz.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';

import '../../../core/errors/failures.dart';
import '../../models/user/user_model.dart';

abstract class CustomerRepo {
  Future<Either<Failures, List<CustomerModel>>> getCustomers();
}

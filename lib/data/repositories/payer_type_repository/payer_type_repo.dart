import 'package:dartz/dartz.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';

abstract class PayerTypeRepo {
  Future<Either<Failures, List<PayerTypeModel>>> getPayerType(
      {required int type});
}

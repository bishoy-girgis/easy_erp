import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../models/payment_type_model/pay_ment_type_model.dart';

abstract class PaymentTypeRepo {
  Future<Either<Failures, List<PaymentTypeModel>>> getPaymentTypes();
}

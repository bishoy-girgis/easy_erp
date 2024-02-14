import 'package:dartz/dartz.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';

import '../../../core/errors/failures.dart';
import '../../models/user/user_model.dart';

abstract class InvoiceRepo {
  Future<Either<Failures, InvoiceModel>> saveInvoice(
      {required InvoiceModel invoiceModel});
}

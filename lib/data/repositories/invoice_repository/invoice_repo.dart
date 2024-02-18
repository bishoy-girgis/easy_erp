import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../models/item_model/item_model.dart';
import '../../models/send_invoice_model/send_invoice_model.dart';

abstract class InvoiceRepo {
  Future<Either<Failures, SendInvoiceModel>> saveInvoice(
      {required List<ItemModel> items});
}

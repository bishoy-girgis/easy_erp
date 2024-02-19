import 'package:dartz/dartz.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';

import '../../../core/errors/failures.dart';
import '../../models/item_model/item_model.dart';
import '../../models/send_invoice_model/send_invoice_model.dart';

abstract class InvoiceRepo {
  Future<Either<Failures, SendInvoiceModel>> saveInvoice(
      {required List<ItemModel> items});
  Future<Either<Failures, List<InvoiceModel>>> getInvoices();
}

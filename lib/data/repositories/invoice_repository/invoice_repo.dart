import 'package:dartz/dartz.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';

import '../../../core/errors/failures.dart';
import '../../models/item_model/item_model.dart';
import '../../models/print_invoice_model/print_invoice_model.dart';
import '../../models/send_invoice_model/send_invoice_model.dart';

abstract class InvoiceRepo {
  Future<Either<Failures, SendInvoiceModel>> saveInvoice({
    required DateTime date,
    required int? custid,
    required int? invtype,
    required String user,
    required int whid,
    required int? ccid,
    required int? branchid,
    required double? netvalue,
    required double? taxAdd,
    required double? finalValue,
    required int? payid,
    required int? bankDtlId,
    required List<ItemModel> items,
  });
  Future<Either<Failures, List<InvoiceModel>>> getInvoices();
  Future<Either<Failures, PrintInvoiceModel>> getInvoiceDataAndItems(
      {required String invNo});
}

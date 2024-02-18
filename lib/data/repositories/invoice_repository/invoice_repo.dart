import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../models/item_model/item_model.dart';
import '../../models/send_invoice_model/send_invoice_model.dart';

abstract class InvoiceRepo {
  Future<Either<Failures, SendInvoiceModel>> saveInvoice({
    required String date,
    int? custid,
    required int invtype,
    required String user,
    required int whid,
    required int ccid,
    required int branchid,
    required double netvalue,
    required double taxAdd,
    required double finalValue,
    required int payid,
    required int bankDtlId,
    required List<ItemModel> itms,
  });
}

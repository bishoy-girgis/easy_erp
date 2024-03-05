import 'package:dartz/dartz.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';

abstract class ReturnRepo {
  Future<Either<Failures, SendInvoiceModel>> saveReturn({
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
    int? invid,
    required List<ItemModel> items,
  });
}

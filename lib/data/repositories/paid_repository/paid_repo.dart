import 'package:dartz/dartz.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/data/models/reciept/send_return_model/send_reciept_model.dart';

abstract class PaidRepo {
  Future<Either<Failures, List<RecieptPaidModel>>> getPaids();

  Future<Either<Failures, SendRecieptModel>> savepaid({
    required DateTime date,
    required String user,
    required int? ccid,
    required int? branchid,
    required int? payid,
    required int? bankDtlId,
    required int? paymentchartid,
    required double? payvalue,
    required double? vatvalue,
    required String notes,
  });
}

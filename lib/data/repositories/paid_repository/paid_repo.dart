import 'package:dartz/dartz.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/paid_model/paid_model.dart';
import 'package:easy_erp/data/models/paid_model/send_paid_model.dart';

abstract class PaidRepo {
  Future<Either<Failures, List<PaidModel>>> getPaids();

  Future<Either<Failures, SendPaidModel>> savepaid({
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

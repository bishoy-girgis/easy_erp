import 'package:dartz/dartz.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_model.dart';
import 'package:easy_erp/data/models/reciept/send_return_model/send_reciept_model.dart';

abstract class RecieptRepo {
  Future<Either<Failures, SendRecieptModel>> saveReciept({
    required DateTime date,
    required String user,
    required String notes,
    required int? ccid,
    required int? branchid,
    required int? payid,
    required int? bankDtlId,
    required int? custchartid,
    required double? recvalue,
  });
  Future<Either<Failures, List<RecieptModel>>> getReciepts();
}

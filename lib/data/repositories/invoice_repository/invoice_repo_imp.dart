import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api_services/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';

import '../../../core/helper/app_constants.dart';
import 'invoice_repo.dart';

class InvoiceRepoImplementation extends InvoiceRepo {
  ApiService apiService;
  InvoiceRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, InvoiceModel>> saveInvoice(
      {required InvoiceModel invoiceModel}) async {
    try {
      print("DATA IN INVOICE REPO IMP ✨✨");
      var data = await apiService.postBody(
        endPoint: AppConstants.LOGIN_AND_TOKEN,
        queryParameters: {
          'date': invoiceModel.date,
          'custid': invoiceModel.custid,
          'invtype': invoiceModel.invtype,
          'user': invoiceModel.user,
          'whid': invoiceModel.whid,
          'ccid': invoiceModel.ccid,
          'branchid': invoiceModel.branchid,
          'netvalue': invoiceModel.netvalue,
          'TaxAdd': invoiceModel.taxAdd,
          'FinalValue': invoiceModel.finalValue,
          'Payid': invoiceModel.payid,
          'bankDtlId': invoiceModel.bankDtlId,
        },
        body: {
          'itms': invoiceModel.itms,
        },
      );
      InvoiceModel invoice = InvoiceModel.fromJson(data);
      return right(invoice);
    } catch (e) {
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}

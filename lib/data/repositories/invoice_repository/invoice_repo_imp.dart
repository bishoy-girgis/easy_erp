import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api_services/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';

import '../../../core/helper/app_constants.dart';
import '../../models/item_model/item_model.dart';
import 'invoice_repo.dart';

class InvoiceRepoImplementation extends InvoiceRepo {
  ApiService apiService;
  InvoiceRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, dynamic>> saveInvoice({
    required DateTime date,
    required int custid,
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
  }) async {
    try {
      print("DATA IN INVOICE REPO IMP ✨✨");
      print(itms.map((item) => item.toJson()).toList());
      var data = await apiService.postBody(
        endPoint: AppConstants.POST_INVOICE,
        queryParameters: {
          'date': date,
          'custid': custid,
          'invtype': invtype,
          'user': user,
          'whid': whid,
          'ccid': ccid,
          'branchid': branchid,
          'netvalue': netvalue,
          'TaxAdd': taxAdd,
          'FinalValue': finalValue,
          'Payid': payid,
          'bankDtlId': bankDtlId,
        },
        body: {
          'itms': itms.map((item) => item.toJson()).toList(),
        },
      );
      return right(data);
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo.dart';

class ReturnRepoImplementation extends ReturnRepo {
  ApiService apiService;
  ReturnRepoImplementation(this.apiService);

  @override
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
  }) async {
    print("LIST OF ITEMS  === > ${items.map((e) => e.toJson()).toList()} \n");
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();

    try {
      Map<String, dynamic> data = await apiService.postBody(
        data: itemsJson,
        endPoint: AppConstants.POST_Return,
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
          'invid': invid ?? 0,
        },
      );
      print('DATATA IN INV REPO' + data.toString());
      SendInvoiceModel sendInvoiceModel = SendInvoiceModel.fromJson(data);
      return right(sendInvoiceModel);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        print(e.toString());
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}

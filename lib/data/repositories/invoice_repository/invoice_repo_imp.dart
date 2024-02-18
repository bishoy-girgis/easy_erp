import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api_services/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/app_constants.dart';
import '../../models/item_model/item_model.dart';
import '../../models/send_invoice_model/send_invoice_model.dart';
import 'invoice_repo.dart';

class InvoiceRepoImplementation extends InvoiceRepo {
  ApiService apiService;
  InvoiceRepoImplementation(this.apiService);

  @override
  Future<Either<Failures, Map<String, dynamic>>> saveInvoice({
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
  }) async {
    try {
      print("INV REPO OOOOOOOOOOO");
      print('Date: $date');
      print('Custid: $custid');
      print('Invtype: $invtype');
      print('User: $user');
      print('Whid: $whid');
      print('Ccid: $ccid');
      print('Branchid: $branchid');
      print('Netvalue: $netvalue');
      print('TaxAdd: $taxAdd');
      print('FinalValue: $finalValue');
      print('Payid: $payid');
      print('BankDtlId: $bankDtlId');
      List<Map<String, dynamic>> itemJsonList =
          itms.map((item) => item.toJson()).toList();
      print("DATA IN INVOICE REPO IMP ✨✨");

      DateTime dateTime = DateFormat('MM/dd/yyyy').parse(date);
      print(dateTime);
      var data = await apiService.postBody(
        endPoint:
            '/api/Invsave/Post?date=01/28/2024&custid=1&invtype=2&user=mostafa&whid=1&ccid=1&branchid=1&netvalue=40.00&TaxAdd=20.00&FinalValue=60.00&Payid=1&bankDtlId=1',
        // queryParameters: {
        //   'date': dateTime,
        //   'custid': custid,
        //   'invtype': invtype,
        //   'user': user,
        //   'whid': whid,
        //   'ccid': ccid,
        //   'branchid': branchid,
        //   'netvalue': netvalue,
        //   'TaxAdd': taxAdd,
        //   'FinalValue': finalValue,
        //   'Payid': payid,
        //   'bankDtlId': bankDtlId,
        // },
        body: itemJsonList,
      );
      print(data['massage']);
      print(data['invno']);
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

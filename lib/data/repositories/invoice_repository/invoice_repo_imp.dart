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
  Future<Either<Failures, SendInvoiceModel>> saveInvoice(
      {required List<ItemModel> items}) async {
    print("LIST OF ITEMS  === > ${items.map((e) => e.toJson()).toList()} \n");
    try {
      Map<String, dynamic> data = await apiService.postBody(
        data: items.map((e) => e.toJson()).toList(),
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

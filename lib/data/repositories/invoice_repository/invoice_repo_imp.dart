import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api_services/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
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
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();

    try {
      Map<String, dynamic> data = await apiService.postBody(
        data: itemsJson,
        endPoint: AppConstants.POST_INVOICE,
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

  @override
  Future<Either<Failures, List<InvoiceModel>>> getInvoices() async {
    try {
      print("DATA IN Customer REPO IMP ✨✨");
      var data = await apiService.get(
        endPoint: AppConstants.GET_INVOICES,
      );

      List<InvoiceModel> invoices = [];
      for (var customer in data) {
        invoices.add(InvoiceModel.fromJson(customer));
      }
      return right(invoices);
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

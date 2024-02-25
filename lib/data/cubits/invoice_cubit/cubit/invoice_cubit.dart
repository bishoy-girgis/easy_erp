import 'package:bloc/bloc.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/repositories/invoice_repository/invoice_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helper/locator.dart';
import '../../../../../data/models/item_model/item_model.dart';
import '../../../../../data/models/send_invoice_model/send_invoice_model.dart';
import '../../../../../data/models/user/user_model.dart';
import '../../addItem_cubit/cubit/add_item_cubit.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.invoiceRepo,
  }) : super(InvoiceInitial());

  InvoiceRepo invoiceRepo;
  static InvoiceCubit get(context) => BlocProvider.of(context);
  saveInvoice({
    required List<ItemModel> items,
  }) async {
    emit(SaveInvoiceLoading());
    print("ALL DATA IN INVOICE CUBIT");
    print('items:');
    items.forEach((item) {
      print('  ${item.toJson()}');
    });
    var result = await invoiceRepo.saveInvoice(
      date: DateFormat('dd/MM/yyyy').parse(SharedPref.get(key: 'invoiceDate') ??
          DateFormat('dd/MM/yyyy').format(DateTime.now())),
      custid: SharedPref.get(key: 'custID') ?? 0,
      invtype: SharedPref.get(key: 'invoiceTypeID') ?? 0,
      user: SharedPref.get(key: 'userName'),
      whid: AppConstants.whId,
      ccid: AppConstants.ccid,
      branchid: SharedPref.get(key: 'branchID') ?? 1,
      netvalue: SharedPref.get(key: 'amountBeforeTex') ?? 0,
      taxAdd: SharedPref.get(key: 'taxAmount') ?? 0,
      finalValue: SharedPref.get(key: 'totalAmount') ?? 0,
      payid: SharedPref.get(key: 'paymentTypeID') ?? 1,
      bankDtlId: SharedPref.get(key: 'bankdtlId') ?? 1,
      items: items,
    );
    print(
        'itemssssssssssssssssssssssssssssssssssssssssssssssssssssssss: 🎶🎶🎶');
    items.forEach((item) {
      print('  ${item.toJson()}');
    });
    if (result != null) {
      result.fold((l) {
        print("ERROR IN INV CUBIT " + l.errorMessage);
        emit(InvoiceNotSave(l.errorMessage));
      }, (r) {
        print(r);
        var sendInvoiceModel = r; // This line should be within the null check
        print(sendInvoiceModel);
        print('DATACUBI(TTTT)' + r.toString());
        emit(InvoiceSavedSuccess(r));
      });
    } else {
      emit(InvoiceNotSave("Invoice data is null"));
    }
  }

  List<InvoiceModel> invoices = [];
  getInvoices() async {
    emit(GetInvoiceLoading());
    final result = await invoiceRepo.getInvoices();
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetInvoiceFailure(error.errorMessage));
    }, (r) {
      /// r for List of customers
      invoices = r;
      removeInvoiceData();

      emit(GetInvoiceSuccess(r));
    });
  }

  removeInvoiceData() {
    SharedPref.remove(key: 'invoiceDate');
    SharedPref.remove(key: 'custID');
    SharedPref.remove(key: 'invoiceTypeID');
    SharedPref.remove(key: 'amountBeforeTex');
    SharedPref.remove(key: 'taxAmount');
    SharedPref.remove(key: 'totalAmount');
    SharedPref.remove(key: 'paymentTypeID');
    SharedPref.remove(key: 'bankdtlId');
    emit(RemoveData());
  }
}

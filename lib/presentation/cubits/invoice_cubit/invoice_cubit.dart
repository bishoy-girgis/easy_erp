import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/pdf_helper.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/models/print_invoice_model/print_invoice_model.dart';
import 'package:easy_erp/data/repositories/invoice_repository/invoice_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/item_model/item_model.dart';
import '../../../../data/models/send_invoice_model/send_invoice_model.dart';
part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.invoiceRepo,
  }) : super(InvoiceInitial());

  InvoiceRepo invoiceRepo;
  static InvoiceCubit get(context) => BlocProvider.of(context);

  List<ItemModel> itemsInvoice = [];

  saveInvoice({
    required List<ItemModel> items,
  }) async {
    emit(SaveInvoiceLoading());
    debugPrint("ALL DATA IN INVOICE CUBIT");
    items.forEach((item) {
      debugPrint('  ${item.toJson()}');
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
    debugPrint(
        'items: 🎶🎶🎶');
    items.forEach((item) {
      debugPrint('  ${item.toJson()}');
    });
    if (result != null) {
      result.fold((l) {
        debugPrint("ERROR IN INV CUBIT ${l.errorMessage}");
        emit(InvoiceNotSave(l.errorMessage));
      }, (r) {
        print(r);
        SendInvoiceModel sendInvoiceModel =
            r; // This line should be within the null check
        print(sendInvoiceModel);
        debugPrint('DATACUBI(TTTT)$r');
        emit(InvoiceSavedSuccess(r));
        return r;
      });
    } else {
      emit(const InvoiceNotSave("Invoice data is null"));
    }
  }

  List<InvoiceModel> invoices = [];
  getInvoices() async {
    emit(GetInvoiceLoading());
    final result = await invoiceRepo.getInvoices();
    result.fold((error) {
      emit(InvoiceInitial());

      debugPrint("🎈🎈🎈🎈${error.errorMessage}");
      emit(GetInvoiceFailure(error.errorMessage));
    }, (r) {
      emit(InvoiceInitial());
      invoices = r;
      emit(GetInvoiceSuccess(r));
    });
  }

  getInvoiceDataAndItems(context, {required String invNo}) async {

    emit(GetInvoiceDataLoading());
    var result = await invoiceRepo.getInvoiceDataAndItems(invNo: invNo);
    result.fold(
      (l) {
        debugPrint('❤️🐸❤️🐸❤️❤️❤️🐸❤️🐸❤️❤️');
        emit(GetInvoiceDataFailure(l.errorMessage));
      },
      (r) {
        PrintInvoiceModel printInvoiceModel = r;
        debugPrint('❤️🐸❤️🐸❤️❤️${printInvoiceModel.invoicedtls.toString()}');
        debugPrint('❤️🐸❤️🐸❤️❤️$invNo');
        emit(GetInvoiceDataSuccess(r));
        DateTime dateTime =
            DateTime.parse(r.invoicehead?[0].invdate ?? "1/1/2000");
        String formattedDate =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
        String? formattedTime;
        if (r.invoicehead![0].invtime == null) {
          DateTime parsedTime = DateFormat('HH:mm')
              .parse("${r.invoicehead![0].invtime ?? "00:00:00"} ");
          formattedTime = DateFormat('h:mm a').format(parsedTime);
        }
        generateAndPrintArabicPdf(context,
            qrData: r.qr ?? "empty",
            invNo: invNo,
            invoTime: formattedTime ?? "0000",
            custName: r.invoicehead?[0].custInvname ?? 'Cash',
            finalValue: r.invoicehead![0].finalValue!,
            netvalue: r.invoicehead![0].netvalue!,
            taxAdd: r.invoicehead![0].taxAdd!,
            invoDate: formattedDate,
            invoiceType: "نسخة من فاتورة ضريبية مبسطة",
            items: r.invoicedtls ?? []);
        getInvoices();
        return printInvoiceModel;
      },
    );
  }

  getInvoiceItems(context, {required String invNo}) async {
    emit(GetInvoiceItemsLoading());
    var result = await invoiceRepo.getInvoiceDataAndItems(invNo: invNo);
    result.fold(
      (l) {
        debugPrint('❤️');
        emit(GetInvoiceItemsFailure(l.errorMessage));
      },
      (r) {
        PrintInvoiceModel printInvoiceModel = r;
        debugPrint('🐸🐸🐸🐸${printInvoiceModel.invoicedtls.toString()}');
        debugPrint('🐸🐸$invNo');
        itemsInvoice = r.invoicedtls ?? [];
        debugPrint("🐸🐸 ${itemsInvoice.length}");
        emit(GetInvoiceItemsSuccess(r.invoicedtls!));
        return itemsInvoice;
      },
    );
  }

  removeInvoiceData() {
    SharedPref.remove(key: 'invoiceDate');
    SharedPref.remove(key: 'custID');
    SharedPref.remove(key: 'custName');
    SharedPref.remove(key: 'invoiceTypeID');
    SharedPref.remove(key: 'amountBeforeTex');
    SharedPref.remove(key: 'taxAmount');
    SharedPref.remove(key: 'totalAmount');
    SharedPref.remove(key: 'paymentTypeID');
    SharedPref.remove(key: 'bankdtlId');
    emit(RemoveData());
  }
}

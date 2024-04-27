import 'package:bloc/bloc.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/pdf_helper.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/return/print_return_model/print_return_model.dart';
import 'package:easy_erp/data/models/return/return_model.dart';
import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReturnCubit extends Cubit<ReturnState> {
  ReturnCubit({
    required this.returnRepo,
  }) : super(ReturnInitial());

  ReturnRepo returnRepo;

  static ReturnCubit get(context) => BlocProvider.of(context);

  List<ReturnModel> returns = [];
  getReturns() async {
    emit(GetReturnLoading());
    final result = await returnRepo.getReturns();
    result.fold((error) {
      emit(ReturnInitial());

      debugPrint("🎈🎈🎈🎈${error.errorMessage}");
      emit(GetReturnFailure(error.errorMessage));
    }, (r) {
      emit(ReturnInitial());
      returns = r;
      emit(GetReturnSuccess(r));
    });
  }

  saveReturn({required List<ItemModel> items, int? invid}) async {
    emit(SaveReturnLoading());
    debugPrint("ALL DATA IN Return CUBIT");
    debugPrint('items:');
    items.forEach((item) {
      debugPrint('  ${item.toJson()}');
    });
    var result = await returnRepo.saveReturn(
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
      invid: invid,
    );
    debugPrint('items🎶🎶🎶🎶🎶🎶🎶🎶🎶');
    items.forEach((item) {
      debugPrint('  ${item.toJson()}');
    });
    if (result != null) {
      result.fold((l) {
        debugPrint("ERROR IN return CUBIT ${l.errorMessage}");
        emit(ReturnNotSave(l.errorMessage));
      }, (r) {
        print(r);
        SendInvoiceModel sendInvoiceModel = r;
        print(sendInvoiceModel);
        debugPrint('DATACUBI(T)$r');
        emit(ReturnSavedSuccess(r));
        return r;
      });
    } else {
      emit(const ReturnNotSave("Invoice data is null"));
    }
  }

  getReturnDataAndItems(context, {required String returnInvNo}) async {
    emit(GetReturnDataLoading());
    var result =
        await returnRepo.getReturnDataAndItems(returnInvNo: returnInvNo);
    result.fold(
      (l) {
        debugPrint('❤️🐸❤️🐸❤️❤️❤️🐸❤️🐸❤️❤️');
        emit(GetReturnDataFailure(l.errorMessage));
      },
      (r) {
        PrintReturnModel printReturnModel = r;
        debugPrint('❤️🐸❤️🐸❤️❤️${printReturnModel.rtninvoicedtls.toString()}');
        debugPrint('❤️🐸❤️🐸❤️❤️$returnInvNo');
        emit(GetReturnDataSuccess(r));
        DateTime dateTime =
            DateTime.parse(r.rtninvoicehead?[0].rtnInvdate ?? "1/1/2000");
        String formattedDate =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
        String? formattedTime;
        if (r.rtninvoicehead![0].invtime == null) {
          DateTime parsedTime = DateFormat('HH:mm')
              .parse("${r.rtninvoicehead![0].invtime ?? "00:00:00"} ");
          formattedTime = DateFormat('h:mm a').format(parsedTime);
        }
        generateAndPrintArabicPdf(context,
            isReturn: true,
            qrData: r.qr ?? "empty",
            invNo: returnInvNo,
            invoTime: formattedTime ?? "0000",
            custName: r.rtninvoicehead?[0].custname ?? 'Cash',
            finalValue: r.rtninvoicehead![0].finalValue!,
            netvalue: r.rtninvoicehead![0].netvalue!,
            taxAdd: r.rtninvoicehead![0].taxAdd!,
            invoDate: formattedDate,
            invoiceType: "نسخة من مرتجع ضريبي مبسط",
            items: r.rtninvoicedtls ?? []);
        getReturns();
        return printReturnModel;
      },
    );
  }
}

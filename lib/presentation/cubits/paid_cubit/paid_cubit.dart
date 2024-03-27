import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/paid_model/send_paid_model.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/data/repositories/paid_repository/paid_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/pdf_reciept.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Paidcubit extends Cubit<PaidState> {
  Paidcubit({
    required this.paidRepo,
  }) : super(PaidInitial());

  PaidRepo paidRepo;

  static Paidcubit get(context) => BlocProvider.of(context);

  List<RecieptPaidModel> paids = [];
  getPaids() async {
    emit(GetPaidLoading());
    final result = await paidRepo.getPaids();
    result.fold((error) {
      emit(PaidInitial());

      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetPaidFailure(error.errorMessage));
    }, (r) {
      /// r for List of customers
      emit(PaidInitial());
      paids = r;
      emit(GetPaidSuccess(r));
    });
  }

  savePaid(context) async {
    emit(SavePaidLoading());
    print("ALL DATA IN Paidd CUBIT");
    var result = await paidRepo.savepaid(
      notes: SharedPref.get(key: 'notesVoucher') ?? "--",
      date: DateFormat('dd/MM/yyyy').parse(SharedPref.get(key: 'invoiceDate') ??
          DateFormat('dd/MM/yyyy').format(DateTime.now())),
      user: SharedPref.get(key: 'userName'),
      ccid: AppConstants.ccid,
      branchid: SharedPref.get(key: 'branchID') ?? 1,
      payid: SharedPref.get(key: 'paymentTypeID') ?? 1,
      bankDtlId: SharedPref.get(key: 'bankdtlId') ?? 1,
      paymentchartid: SharedPref.get(key: 'PayerChartId') ?? 1,
      payvalue: SharedPref.get(key: 'paidVoucher'),
      vatvalue: SharedPref.get(key: 'taxVoucher'),
    );

    if (result != null) {
      result.fold((l) {
        print("ERROR IN Paid CUBIT " + l.errorMessage);
        emit(PaidNotSave(l.errorMessage));
      }, (r) {
        print(r);
        SendPaidModel sendPaidModel = r;
        print('DATACUBI(TTTT)' + r.toString());
        generatePdfReciept(context,
            pdfType: "فاتوره سند صرف",
            voucherNo: sendPaidModel.payNo.toString(),
            voucherDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            voucherTime: DateFormat('h:mm a').format(DateTime.now()),
            voucherValue: SharedPref.get(key: 'paidVoucher') ?? 00,
            voucherNotes: SharedPref.get(key: 'notesVoucher') ?? "--",
            payerName:
                SharedPref.get(key: 'PayerChartName') ?? "payerChartName",
            voucherPaymentType:
                SharedPref.get(key: 'paymebtTypeName') ?? "cash");
        emit(PaidSavedSuccess(r));
        return r;
      });
    } else {
      emit(const PaidNotSave("Paid data is null"));
    }
  }
}

import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_model.dart';
import 'package:easy_erp/data/models/reciept/send_return_model/send_reciept_model.dart';
import 'package:easy_erp/data/repositories/reciept_repository/reciept_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Recieptcubit extends Cubit<RecieptState> {
  Recieptcubit({
    required this.recieptRepo,
  }) : super(RecieptInitial());

  RecieptRepo recieptRepo;

  static Recieptcubit get(context) => BlocProvider.of(context);

  List<RecieptModel> reciepts = [];
  getReciepts() async {
    emit(GetRecieptLoading());
    final result = await recieptRepo.getReciepts();
    result.fold((error) {
      emit(RecieptInitial());

      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetRecieptFailure(error.errorMessage));
    }, (r) {
      /// r for List of customers
      emit(RecieptInitial());
      reciepts = r;
      emit(GetRecieptSuccess(r));
    });
  }

  saveReciept() async {
    emit(SaveRecieptLoading());
    print("ALL DATA IN Reciept CUBIT");
    var result = await recieptRepo.saveReciept(
      date: DateFormat('dd/MM/yyyy').parse(SharedPref.get(key: 'invoiceDate') ??
          DateFormat('dd/MM/yyyy').format(DateTime.now())),
      user: SharedPref.get(key: 'userName'),
      ccid: AppConstants.ccid,
      branchid: SharedPref.get(key: 'branchID') ?? 1,
      payid: SharedPref.get(key: 'paymentTypeID') ?? 1,
      bankDtlId: SharedPref.get(key: 'bankdtlId') ?? 1,
      custchartid: SharedPref.get(key: 'PayerChartId') ?? 1,
      recvalue: SharedPref.get(key: 'recieptVoucher') ?? 0,
    );

    if (result != null) {
      result.fold((l) {
        print("ERROR IN Reciept CUBIT " + l.errorMessage);
        emit(RecieptNotSave(l.errorMessage));
      }, (r) {
        print(r);
        SendRecieptModel sendRecieptModel = r;
        print(sendRecieptModel);
        print('DATACUBI(TTTT)' + r.toString());
        emit(RecieptSavedSuccess(r));
        return r;
      });
    } else {
      emit(const RecieptNotSave("Reciept data is null"));
    }
  }
}

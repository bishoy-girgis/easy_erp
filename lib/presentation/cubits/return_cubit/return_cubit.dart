import 'package:bloc/bloc.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Returncubit extends Cubit<ReturnState> {
  Returncubit({
    required this.returnRepo,
  }) : super(ReturnInitial());

  ReturnRepo returnRepo;

  static Returncubit get(context) => BlocProvider.of(context);

  saveReturn({required List<ItemModel> items, int? invid}) async {
    emit(SaveReturnLoading());
    print("ALL DATA IN Return CUBIT");
    print('items:');
    items.forEach((item) {
      print('  ${item.toJson()}');
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
    print(
        'itemssssssssssssssssssssssssssssssssssssssssssssssssssssssss: 🎶🎶🎶');
    items.forEach((item) {
      print('  ${item.toJson()}');
    });
    if (result != null) {
      result.fold((l) {
        print("ERROR IN INV CUBIT " + l.errorMessage);
        emit(ReturnNotSave(l.errorMessage));
      }, (r) {
        print(r);
        SendInvoiceModel sendInvoiceModel =
            r; // This line should be within the null check
        print(sendInvoiceModel);
        print('DATACUBI(TTTT)' + r.toString());
        emit(ReturnSavedSuccess(r));
        return r;
      });
    } else {
      emit(ReturnNotSave("Invoice data is null"));
    }
  }
}

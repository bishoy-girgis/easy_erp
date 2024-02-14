import 'package:bloc/bloc.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/repositories/invoice_repository/invoice_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/item_model/item_model.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.invoiceRepo,
  }) : super(InvoiceInitial());
  InvoiceRepo invoiceRepo;
  InvoiceCubit get(context) => BlocProvider.of(context);
  final DateTime date = DateTime.now();
  int? custid;
  int? invtype;
  String user = SharedPref.get(key: "userName");
  int whid = SharedPref.get(key: "whid");
  int? ccid;
  int? branchid;
  double? netvalue;
  double? taxAdd;
  double? finalValue;
  int? payid;
  int? bankDtlId;
  List<ItemModel>? itms;
  saveInvoice() {
    emit(SaveInvoiceLoading());
    invoiceRepo.saveInvoice(
        date: date,
        custid: custid ?? 0,
        invtype: invtype!,
        user: user,
        whid: whid,
        ccid: ccid ?? 0,
        branchid: branchid ?? 0,
        netvalue: netvalue ?? 0,
        taxAdd: taxAdd ?? 0,
        finalValue: finalValue ?? 0,
        payid: payid ?? 0,
        bankDtlId: bankDtlId ?? 0,
        itms: itms!);
  }
}

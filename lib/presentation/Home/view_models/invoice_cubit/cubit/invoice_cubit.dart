import 'package:bloc/bloc.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/repositories/invoice_repository/invoice_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../core/helper/locator.dart';
import '../../../../../data/models/item_model/item_model.dart';
import '../../../../../data/models/user/user_model.dart';
import '../../addItem_cubit/cubit/add_item_cubit.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit({
    required this.invoiceRepo,
  }) : super(InvoiceInitial());

  InvoiceRepo invoiceRepo;
  static InvoiceCubit get(context) => BlocProvider.of(context);
  // var userBox = Hive.box<UserModel>("userBox");
  // var customerBox = Hive.box<CustomerModel>("customerBox");
  final DateTime date = DateTime.now();

  List<ItemModel>? itms;
  saveInvoice({
    required DateTime date,
    required int custid,
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
    emit(SaveInvoiceLoading());
    var result = await invoiceRepo.saveInvoice(
      bankDtlId: bankDtlId,
      invtype: invtype,
      user: user,
      whid: whid,
      ccid: ccid,
      branchid: branchid,
      custid: custid,
      date: date,
      netvalue: netvalue,
      taxAdd: taxAdd,
      finalValue: finalValue,
      payid: payid,
      itms: itms,
    );
    result.fold((l) {
      print(l.errorMessage);
      print("---------------------------------");

      emit(InvoiceNotSave(l.errorMessage));
    }, (r) {
      print("-------------ssssssssss--------------------");
      emit(
        InvoiceSavedSuccess(r),
      );
    });
  }
}

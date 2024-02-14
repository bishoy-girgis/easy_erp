import 'package:bloc/bloc.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/repositories/invoice_repository/invoice_repo.dart';
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
  // final int custid;
  // final int invtype;
  // final String user;
  // final int whid;
  // final int ccid;
  // final int branchid;
  // final double netvalue;
  // final double taxAdd;
  // final double finalValue;
  // final int payid;
  // final int bankDtlId;
  // final List<ItemModel> itms;
  saveInvoice() {}
}

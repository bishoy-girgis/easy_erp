import 'package:bloc/bloc.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:equatable/equatable.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
}

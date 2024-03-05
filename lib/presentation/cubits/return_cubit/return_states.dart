import 'package:easy_erp/data/models/send_invoice_model/send_invoice_model.dart';
import 'package:equatable/equatable.dart';

sealed class ReturnState extends Equatable {
  const ReturnState();

  @override
  List<Object> get props => [];
}

final class ReturnInitial extends ReturnState {}

final class SaveReturnLoading extends ReturnState {}

final class ReturnSavedSuccess extends ReturnState {
  final SendInvoiceModel sendInvoiceModel;
  const ReturnSavedSuccess(this.sendInvoiceModel);
}

final class ReturnNotSave extends ReturnState {
  final String error;
  const ReturnNotSave(this.error);
}

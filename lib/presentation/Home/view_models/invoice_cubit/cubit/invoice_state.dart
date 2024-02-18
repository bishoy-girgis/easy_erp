part of 'invoice_cubit.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

final class SaveInvoiceLoading extends InvoiceState {}

final class InvoiceSavedSuccess extends InvoiceState {
  final SendInvoiceModel sendInvoiceModel;
  const InvoiceSavedSuccess(this.sendInvoiceModel);
}

final class InvoiceNotSave extends InvoiceState {
  final String error;
  const InvoiceNotSave(this.error);
}

part of 'invoice_cubit.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

final class SaveInvoiceLoading extends InvoiceState {}

final class InvoiceSavedSuccess extends InvoiceState {
  dynamic response;
  InvoiceSavedSuccess(this.response);
}

final class InvoiceNotSave extends InvoiceState {
  dynamic error;
  InvoiceNotSave(this.error);
}

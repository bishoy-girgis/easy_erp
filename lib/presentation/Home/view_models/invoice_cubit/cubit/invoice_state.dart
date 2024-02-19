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

final class GetInvoiceLoading extends InvoiceState {}

final class GetInvoiceSuccess extends InvoiceState {
  final List<InvoiceModel> invoiceModels;
  const GetInvoiceSuccess(this.invoiceModels);
}

final class GetInvoiceFailure extends InvoiceState {
  final String error;
  const GetInvoiceFailure(this.error);
}

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

final class RemoveData extends InvoiceState {}

final class GetInvoiceSuccess extends InvoiceState {
  final List<InvoiceModel> invoiceModels;
  const GetInvoiceSuccess(this.invoiceModels);
}

final class GetInvoiceFailure extends InvoiceState {
  final String error;
  const GetInvoiceFailure(this.error);
}

final class GetInvoiceDataLoading extends InvoiceState {}

final class GetInvoiceDataSuccess extends InvoiceState {
  final PrintInvoiceModel printInvoiceModel;
  const GetInvoiceDataSuccess(this.printInvoiceModel);
}

final class GetInvoiceDataFailure extends InvoiceState {
  final String error;
  const GetInvoiceDataFailure(this.error);
}

final class GetInvoiceItemsLoading extends InvoiceState {}

final class GetInvoiceItemsSuccess extends InvoiceState {
  final List<ItemModel> invoiceItems;
  const GetInvoiceItemsSuccess(this.invoiceItems);
}

final class GetInvoiceItemsFailure extends InvoiceState {
  final String error;
  const GetInvoiceItemsFailure(this.error);
}

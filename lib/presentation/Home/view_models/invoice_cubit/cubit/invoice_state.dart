part of 'invoice_cubit.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

final class SaveInvoiceLoading extends InvoiceState {}

final class InvoiceSaveSuccess extends InvoiceState {}

final class InvoiceNotSave extends InvoiceState {}

import 'package:easy_erp/data/models/return/print_return_model/print_return_model.dart';
import 'package:easy_erp/data/models/return/return_model.dart';
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

final class GetReturnLoading extends ReturnState {}

final class GetReturnSuccess extends ReturnState {
  final List<ReturnModel> returnModels;
  const GetReturnSuccess(this.returnModels);
}

final class GetReturnFailure extends ReturnState {
  final String error;
  const GetReturnFailure(this.error);
}

final class GetReturnDataLoading extends ReturnState {}

final class GetReturnDataSuccess extends ReturnState {
  final PrintReturnModel printReturnModel;
  const GetReturnDataSuccess(this.printReturnModel);
}

final class GetReturnDataFailure extends ReturnState {
  final String error;
  const GetReturnDataFailure(this.error);
}

import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/data/models/reciept/send_return_model/send_reciept_model.dart';
import 'package:equatable/equatable.dart';

sealed class RecieptState extends Equatable {
  const RecieptState();

  @override
  List<Object> get props => [];
}

final class RecieptInitial extends RecieptState {}

final class GetRecieptLoading extends RecieptState {}

final class GetRecieptSuccess extends RecieptState {
  final List<RecieptPaidModel> recieptModel;
  const GetRecieptSuccess(this.recieptModel);
}

final class GetRecieptFailure extends RecieptState {
  final String error;
  const GetRecieptFailure(this.error);
}

final class SaveRecieptLoading extends RecieptState {}

final class RecieptSavedSuccess extends RecieptState {
  final SendRecieptModel sendRecieptModel;
  const RecieptSavedSuccess(this.sendRecieptModel);
}

final class RecieptNotSave extends RecieptState {
  final String error;
  const RecieptNotSave(this.error);
}

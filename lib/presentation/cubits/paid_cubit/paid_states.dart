import 'package:easy_erp/data/models/paid_model/send_paid_model.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:equatable/equatable.dart';

sealed class PaidState extends Equatable {
  const PaidState();

  @override
  List<Object> get props => [];
}

final class PaidInitial extends PaidState {}

final class GetPaidLoading extends PaidState {}

final class GetPaidSuccess extends PaidState {
  final List<RecieptPaidModel> paidModel;
  const GetPaidSuccess(this.paidModel);
}

final class GetPaidFailure extends PaidState {
  final String error;
  const GetPaidFailure(this.error);
}

final class SavePaidLoading extends PaidState {}

final class PaidSavedSuccess extends PaidState {
  final SendPaidModel sendPaidModel;
  const PaidSavedSuccess(this.sendPaidModel);
}

final class PaidNotSave extends PaidState {
  final String error;
  const PaidNotSave(this.error);
}

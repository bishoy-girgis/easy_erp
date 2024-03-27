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

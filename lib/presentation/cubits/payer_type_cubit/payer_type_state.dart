import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';
import 'package:equatable/equatable.dart';

sealed class PayerTypeState extends Equatable {
  const PayerTypeState();

  @override
  List<Object> get props => [];
}

final class PayerTypeInitial extends PayerTypeState {}

final class PayerTypeLoading extends PayerTypeState {}

final class PayerTypeSuccess extends PayerTypeState {
  final List<PayerTypeModel> payTypes;

  PayerTypeSuccess({required this.payTypes});
}

final class PayerTypeFail extends PayerTypeState {
  final String errorMessage;

  PayerTypeFail({required this.errorMessage});
}

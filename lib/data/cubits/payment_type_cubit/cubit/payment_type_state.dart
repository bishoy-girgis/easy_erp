part of 'payment_type_cubit.dart';

sealed class PaymentTypeState extends Equatable {
  const PaymentTypeState();

  @override
  List<Object> get props => [];
}

final class PaymentTypeInitial extends PaymentTypeState {}

final class PaymentTypeLoading extends PaymentTypeState {}

final class PaymentTypeSuccess extends PaymentTypeState {
  final List<PaymentTypeModel> payTypes;

  PaymentTypeSuccess({required this.payTypes});
}

final class PaymentTypeFail extends PaymentTypeState {
  final String errorMessage;

  PaymentTypeFail({required this.errorMessage});
}

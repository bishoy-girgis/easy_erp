part of 'customer_cubit.dart';

sealed class GetCustomerState extends Equatable {
  const GetCustomerState();

  @override
  List<Object> get props => [];
}

final class GetCustomerInitial extends GetCustomerState {}

final class GetCustomerSuccessState extends GetCustomerState {
  final List<CustomerModel> customers;
  const GetCustomerSuccessState({required this.customers});
}

final class GetCustomerFailureState extends GetCustomerState {
  final String error;
  const GetCustomerFailureState({required this.error});
}

final class GetCustomerLoadingState extends GetCustomerState {}

part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}

final class GetCustomerSuccessState extends CustomerState {
  final List<CustomerModel> customers;
  const GetCustomerSuccessState({required this.customers});
}

final class GetCustomerFailureState extends CustomerState {
  final String error;
  const GetCustomerFailureState({required this.error});
}

final class GetCustomerLoadingState extends CustomerState {}

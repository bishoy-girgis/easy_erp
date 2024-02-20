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

final class GetCustomerGroupSuccess extends CustomerState {
  final List<GroupModel> groups;
  const GetCustomerGroupSuccess({required this.groups});
}

final class GetCustomerGroupFailure extends CustomerState {
  final String error;
  const GetCustomerGroupFailure({required this.error});
}

final class GetCustomerGroupLoading extends CustomerState {}

final class AddCustomerSuccess extends CustomerState {
  final AddCustomerResponseModel addCustomerResponseModel;
  const AddCustomerSuccess({required this.addCustomerResponseModel});
}

final class AddCustomerFailure extends CustomerState {
  final String error;
  const AddCustomerFailure({required this.error});
}

final class AddCustomerLoading extends CustomerState {}

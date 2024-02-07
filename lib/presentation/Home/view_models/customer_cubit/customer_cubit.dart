import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_state.dart';

class GetCustomerCubit extends Cubit<GetCustomerState> {
  GetCustomerCubit({required this.customerRepo}) : super(GetCustomerInitial());
  static GetCustomerCubit get(context) => BlocProvider.of(context);
  final CustomerRepo customerRepo;
  List<CustomerModel> customers = [];
  getCustomers() async {
    emit(GetCustomerLoadingState());
    final result = await customerRepo.getCustomers();
    emit(GetCustomerSuccessState(customers: customers));
    result.fold((error) {
      emit(GetCustomerFailureState(error: error.errorMessage));
    }, (r) {
      /// r for List of customers
      customers = r;
      emit(GetCustomerSuccessState(customers: r));
    });
  }
}

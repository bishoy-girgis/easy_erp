import 'dart:io';

import 'package:easy_erp/data/models/add_customer_response_model/add_customer_response_model.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/group_model/group_model.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit({required this.customerRepo}) : super(CustomerInitial());
  static CustomerCubit get(context) => BlocProvider.of(context);
  final CustomerRepo customerRepo;
  List<CustomerModel> customers = [];
  getCustomers() async {
    emit(GetCustomerLoadingState());
    final result = await customerRepo.getCustomers();
    // emit(GetCustomerSuccessState(customers: customers));
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetCustomerFailureState(error: error.errorMessage));
    }, (r) {
      /// r for List of customers
      customers = r;
      emit(GetCustomerSuccessState(customers: r));
    });
  }

  List<GroupModel> groups = [];
  getCustomerGroups() async {
    emit(GetCustomerGroupLoading());
    final result = await customerRepo.getGroups();
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetCustomerGroupFailure(error: error.errorMessage));
    }, (r) {
      groups = r;
      emit(GetCustomerGroupSuccess(groups: r));
      return groups;
    });
  }

  addCustomer({
    required String custNameAr,
    String? custNameEn,
    String? fax,
    String? mobileNumber,
    String? addressAr,
    String? addressEn,
    String? mangNameAr,
    String? mangNameEn,
    required int groupID,
  }) async {
    emit(AddCustomerLoading());
    var result = await customerRepo.addCustomer(
      custNameAr: custNameAr,
      custNameEn: custNameEn ?? "N/A",
      fax: fax ?? "N/A",
      mobileNumber: mobileNumber ?? "N/A",
      addressAr: addressAr ?? "N/A",
      addressEn: addressEn ?? "N/A",
      mangNameAr: mangNameAr ?? "N/A",
      mangNameEn: mangNameEn ?? "N/A",
      groupID: groupID,
    );
    result.fold(
        (l) => emit(
              AddCustomerFailure(error: l.errorMessage),
            ), (r) {
      AddCustomerResponseModel addCustomerResponseModel = r;
      emit(
        AddCustomerSuccess(
          addCustomerResponseModel: addCustomerResponseModel,
        ),
      );
      print(" HHHHWEEEEEYYYYYYYYYYYYYYYY $custNameAr");
      getCustomers();
      return r;
    });
  }
}

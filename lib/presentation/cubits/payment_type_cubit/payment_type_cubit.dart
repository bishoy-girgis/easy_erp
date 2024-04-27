import 'package:bloc/bloc.dart';
import 'package:easy_erp/data/models/payment_type_model/pay_ment_type_model.dart';
import 'package:easy_erp/data/repositories/payment_type_repository/payment_type_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_type_state.dart';

class PaymentTypeCubit extends Cubit<PaymentTypeState> {
  PaymentTypeCubit(this.payTypeRepo) : super(PaymentTypeInitial());
  static PaymentTypeCubit get(context) => BlocProvider.of(context);
  final PaymentTypeRepo payTypeRepo;
  List<PaymentTypeModel> payModels = [];
  getPaymentTypes() async {
    emit(PaymentTypeLoading());
    final result = await payTypeRepo.getPaymentTypes();
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈${error.errorMessage}");
      emit(PaymentTypeFail(errorMessage: error.errorMessage));
    }, (r) {
      payModels = r;

      emit(PaymentTypeSuccess(payTypes: r));
      return payModels;
    });
  }
}

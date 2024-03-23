import 'package:easy_erp/data/models/payer_model/payer_type_model.dart';
import 'package:easy_erp/data/repositories/payer_type_repository/payer_type_repo.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayerTypeCubit extends Cubit<PayerTypeState> {
  PayerTypeCubit(this.payerTypeRepo) : super(PayerTypeInitial());
  static PayerTypeCubit get(context) => BlocProvider.of(context);
  final PayerTypeRepo payerTypeRepo;
  List<PayerTypeModel> payerModels = [];
  getPayerTypes({required int type}) async {
    emit(PayerTypeLoading());
    final result = await payerTypeRepo.getPayerType(type: type);
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(PayerTypeFail(errorMessage: error.errorMessage));
    }, (r) {
      /// r for List of payers type
      payerModels = r;
      emit(PayerTypeSuccess(payTypes: r));
      return payerModels;
    });
  }
}

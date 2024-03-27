import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/data/repositories/paid_repository/paid_repo.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Paidcubit extends Cubit<PaidState> {
  Paidcubit({
    required this.paidRepo,
  }) : super(PaidInitial());

  PaidRepo paidRepo;

  static Paidcubit get(context) => BlocProvider.of(context);

  List<RecieptPaidModel> paids = [];
  getPaids() async {
    emit(GetPaidLoading());
    final result = await paidRepo.getPaids();
    result.fold((error) {
      emit(PaidInitial());

      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetPaidFailure(error.errorMessage));
    }, (r) {
      /// r for List of customers
      emit(PaidInitial());
      paids = r;
      emit(GetPaidSuccess(r));
    });
  }
}

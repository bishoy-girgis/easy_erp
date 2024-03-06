import 'package:bloc/bloc.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/repositories/item_repository/item_repo.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_state.dart';

class GetItemCubit extends Cubit<GetItemState> {
  GetItemCubit({required this.itemRepo}) : super(GetItemsInitial());
  static GetItemCubit get(context) => BlocProvider.of(context);
  final ItemRepo itemRepo;
  List<ItemModel> items = [];
  getItems() async {
    int? invId = SharedPref.get(key: "ReturnSelectedId");
    emit(GetItemsLoadingState());
    print("[[[[[[[[[[]]]]]]]]]]]]");
    final result = await itemRepo.getItems(invId ?? 0);
    print("[[[[[[[[[[222]]]]]]]]]]]]");
    result.fold((error) {
      debugPrint("🎈🎈🎈🎈" + error.errorMessage);
      emit(GetItemsFailureState(error: error.errorMessage));
    }, (r) {
      /// r for List of items
      print("${r.length} lengthhh in cubitttt");
      items = r;
      print("${invId}");
      emit(GetItemsSuccessState(items: r));
      return items;
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/item_model/item_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());
  List<ItemModel> addedItems = [];

  bool checkItemInList(ItemModel item) {
    if (addedItems.contains(item)) {
      // emit(ItemFound());
      return true;
    } else {
      // emit(ItemNotFound());
      return false;
    }
  }

  List<ItemModel> removeItem(ItemModel item) {
    emit(AddItemInitial());
    addedItems.removeWhere(
      (element) {
        return element.itmid == item.itmid;
      },
    );
    emit(ItemRemovedSuccess(addedItems));
    return addedItems;
  }

  List<ItemModel> addItem(ItemModel item) {
    emit(AddItemInitial());
    addedItems.add(item);
    emit(AddItemAddedSuccess(addedItems));
    return addedItems;
  }

  // bool checkListEmpty() {
  //   // emit(AddItemInitial());
  //   if (addedItems.isEmpty) {
  //     emit(ItemsListEmpty());
  //     return true;
  //   } else {
  //     emit(ItemsListNotEmpty());
  //     return false;
  //   }
  // }
}

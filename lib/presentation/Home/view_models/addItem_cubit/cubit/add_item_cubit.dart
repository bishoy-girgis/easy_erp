import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/item_model/item_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());
  List<ItemModel> addedItems = [];

  getAddedItems(ItemModel item) {
    if (addedItems.contains(item)) {
      addedItems.remove(item);
      emit(AddItemRemovedSuccess(addedItems));
    } else {
      addedItems.add(item);
      emit(AddItemAddedSuccess(addedItems));
    }
  }
}

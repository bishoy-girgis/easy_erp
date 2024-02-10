import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/item_model/item_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());
  List<ItemModel> addedItems = [];
  bool isSelected = false;
  void addItem(ItemModel item) {
    addedItems.add(item);
    changeSelected();
    emit(AddItemAddedSuccess(addedItems));
  }

  changeSelected() {
    isSelected = !isSelected;
    emit(ChangeSelected());
  }

  void removeItem(ItemModel item) {
    addedItems.remove(item);
    changeSelected();
    emit(AddItemRemovedSuccess());
  }
}

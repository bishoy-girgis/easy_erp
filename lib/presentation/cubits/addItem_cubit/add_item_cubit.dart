import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/item_model/item_model.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());
  List<ItemModel> addedItems = [];
  List<double> addItemsPrices = [];
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

  removeAllItems() {
    emit(AddItemInitial());

    addedItems.clear();
    emit(RemoveAllItemSuccess());
  }

  List<ItemModel> addItem(ItemModel item) {
    emit(AddItemInitial());
    addedItems.add(item);
    emit(AddItemAddedSuccess(addedItems));
    return addedItems;
  }

  changeQuantity() {
    emit(AddItemInitial());
    emit(ChangeQuantityState());
  }

  void checkAndMergeDuplicates() {
    emit(AddItemInitial());

    Map<int, ItemModel> itemMap = {}; // Map to store items by their ids

    // Iterate through the addedItems list
    for (ItemModel item in addedItems) {
      if (itemMap.containsKey(item.itmid)) {
        // If the item already exists in the map, update its quantity
        ItemModel? existingItem = itemMap[item.itmid];
        existingItem!.quantity += item.quantity;
      } else {
        // If the item does not exist, add it to the map
        itemMap[item.itmid!] = item;
      }
    }

    // Clear addedItems list and add items from the map with merged quantities
    addedItems.clear();
    addedItems.addAll(itemMap.values);

    emit(AddItemAddedSuccess(addedItems));
  }
}

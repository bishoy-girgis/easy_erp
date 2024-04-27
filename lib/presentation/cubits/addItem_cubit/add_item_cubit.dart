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
      return true;
    } else {
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

  changePrice() {
    emit(AddItemInitial());
    emit(ChangePriceState());
  }

  void checkAndMergeDuplicates() {
    emit(AddItemInitial());

    Map<int, ItemModel> itemMap = {};


    for (ItemModel item in addedItems) {
      if (itemMap.containsKey(item.itmid)) {
        ItemModel? existingItem = itemMap[item.itmid];
        existingItem!.quantity += item.quantity;
      } else {
        itemMap[item.itmid!] = item;
      }
    }

    addedItems.clear();
    addedItems.addAll(itemMap.values);

    emit(AddItemAddedSuccess(addedItems));
  }

  void checkAndMergeDuplicatesList(List<ItemModel> newItems) {
    emit(AddItemInitial());

    Map<int, ItemModel> itemMap = {};

    for (ItemModel item in addedItems) {
      itemMap[item.itmid!] = item;
    }

    for (ItemModel newItem in newItems) {
      num newItemQuantity = newItem.quantity;
      if (itemMap.containsKey(newItem.itmid)) {
        ItemModel? existingItem = itemMap[newItem.itmid];
        num totalQuantity = existingItem!.quantity + newItemQuantity;
        if (totalQuantity <= existingItem.quantity) {
          existingItem.quantity = totalQuantity;
        } else {
          existingItem.quantity = existingItem.quantity;
        }
      }
    }

    emit(AddItemAddedSuccess(addedItems));
  }
}

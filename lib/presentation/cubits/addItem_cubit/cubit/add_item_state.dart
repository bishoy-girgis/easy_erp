part of 'add_item_cubit.dart';

sealed class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object> get props => [];
}

final class AddItemInitial extends AddItemState {}

final class AddItemAddedSuccess extends AddItemState {
  final List<ItemModel> items;

  const AddItemAddedSuccess(this.items);

  @override
  List<Object> get props => [items];
}

final class ChangeSelected extends AddItemState {}

final class ItemRemovedSuccess extends AddItemState {
  final List<ItemModel> items;

  const ItemRemovedSuccess(this.items);

  @override
  List<Object> get props => [items];
}

final class RemoveAllItemSuccess extends AddItemState {}

final class ChangeQuantityState extends AddItemState {}
// final class ItemFound extends AddItemState {}

// final class ItemNotFound extends AddItemState {}

// final class ItemsListEmpty extends AddItemState {}

// final class ItemsListNotEmpty extends AddItemState {}

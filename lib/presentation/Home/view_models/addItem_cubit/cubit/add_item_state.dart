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

final class AddItemRemovedSuccess extends AddItemState {}

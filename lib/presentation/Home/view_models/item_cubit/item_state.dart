part of 'item_cubit.dart';

sealed class GetItemState extends Equatable {
  const GetItemState();

  @override
  List<Object> get props => [];
}

final class GetItemsInitial extends GetItemState {}

final class GetItemsSuccessState extends GetItemState {
  final List<ItemModel> items;
  const GetItemsSuccessState({required this.items});
}

final class GetItemsFailureState extends GetItemState {
  final String error;
  const GetItemsFailureState({required this.error});
}

final class GetItemsLoadingState extends GetItemState {}

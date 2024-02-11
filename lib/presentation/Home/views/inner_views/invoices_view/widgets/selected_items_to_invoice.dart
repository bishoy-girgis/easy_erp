import 'package:flutter/material.dart';

import '../../../../../../data/models/item_model/item_model.dart';
import 'selected_item.dart';

class SelectedItemsToInvoice extends StatelessWidget {
  final List<ItemModel> items;

  const SelectedItemsToInvoice({
    Key? key,
    required this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SelectedItem(
          itemModel: items[index],
        );
      },
    );
  }
}

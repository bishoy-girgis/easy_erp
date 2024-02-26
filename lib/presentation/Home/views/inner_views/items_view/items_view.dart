import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/data/cubits/item_cubit/item_cubit.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/text_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/item_widget.dart';

class ItemsView extends StatefulWidget {
  ItemsView({
    super.key,
  });

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  TextEditingController searchController = TextEditingController();

  List<ItemModel> items = [];

  List<ItemModel> searchForItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.items.toLowerCase(),
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: AppLocalizations.of(context)!.search,
              hintText:
                  AppLocalizations.of(context)!.search_with_id_code_barcode,
              controller: searchController,
              suffixIcon: Icons.search,
              backgroundOfTextFeild: Colors.white,
              onChange: (v) {
                searchController.text = v;
                searchForItems = items
                    .where(
                      (item) =>
                          item.itmname!.toLowerCase().startsWith(v) ||
                          item.itmcode!.toLowerCase().startsWith(v) ||
                          item.unitname!.toString().startsWith(v),
                    )
                    .toList();
                setState(() {});
              },
            ),
            const GapH(h: 1),
            BlocBuilder<GetItemCubit, GetItemState>(
              builder: (context, state) {
                if (state is GetItemsSuccessState) {
                  items = state.items;
                  return Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.whiteColor,
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemCount: searchForItems.isNotEmpty
                            ? searchForItems.length
                            : state.items.length,
                        itemBuilder: (context, index) {
                          return ItemWidget(
                            item: searchForItems.isNotEmpty
                                ? searchForItems[index]
                                : state.items[index],
                          );
                        }),
                  ));
                } else if (state is GetItemsFailureState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is GetItemsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text(state.runtimeType.toString()),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

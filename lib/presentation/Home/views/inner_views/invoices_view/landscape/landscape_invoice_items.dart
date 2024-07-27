import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/landscape/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/helper/locator.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../../data/models/item_model/item_model.dart';
import '../../../../../../data/services/local/shared_pref.dart';
import '../../../../../cubits/addItem_cubit/add_item_cubit.dart';
import '../../../../../cubits/item_cubit/item_cubit.dart';
import '../../add_items_view/widgets/item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/selected_item.dart';
import '../widgets/selected_items_to_invoice.dart';

class LandscapeInvoiceItems extends StatefulWidget {
  const LandscapeInvoiceItems({super.key});

  @override
  State<LandscapeInvoiceItems> createState() => _LandscapeInvoiceItemsState();
}

class _LandscapeInvoiceItemsState extends State<LandscapeInvoiceItems> {
  late List<ItemModel> searchForItems;

  TextEditingController searchController = TextEditingController();

  late List<ItemModel> allItems = [];

  Widget buildLoadedListWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CustomTextFormField(
            labelText: AppLocalizations.of(context)!.search,
            hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
            suffixIcon: Icons.search,
            controller: searchController,
            prefixIcon: Icons.qr_code_rounded,
            backgroundOfTextFeild: Colors.white,
            onChange: (v) {
              searchController.text = v;
              searchForItems = allItems
                  .where((item) =>
                      item.itmname!.toLowerCase().contains(v) ||
                      item.itmename!.toLowerCase().startsWith(v) ||
                      item.itmid!.toString().startsWith(v))
                  .toList();
              setState(() {});
            },
          ),
          const GapH(h: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: SearchOnCategorySection(labelText: "Print")),
              SizedBox(width: 2.w), // Spacing between dropdowns
              const Expanded(
                  child: SearchOnCategorySection(labelText: "Pencil")),
              SizedBox(width: 2.w), // Spacing between dropdowns
              const Expanded(
                  child: SearchOnCategorySection(labelText: "Papers")),
            ],
          ),
          const GapH(h: 1),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.grey.withOpacity(0.65),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 7.h,
                  childAspectRatio: 0.75.r,
                ),
                itemCount: searchController.text.isEmpty
                    ? allItems.length
                    : searchForItems.length,
                itemBuilder: (context, index) {
                  return AddItemWidget(
                    itemModel: searchController.text.isEmpty
                        ? allItems[index]
                        : searchForItems[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: BlocBuilder<GetItemCubit, GetItemState>(
                builder: (context, state) {
                  debugPrint("${SharedPref.get(key: "ReturnSelectedId")}");
                  if (state is GetItemsSuccessState) {
                    allItems = state.items;
                    debugPrint("${allItems.length} length list");
                    return buildLoadedListWidgets();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Flexible(
              flex: 3,
              child: BlocBuilder<AddItemCubit, AddItemState>(
                builder: (context, state) {
                  var items = BlocProvider.of<AddItemCubit>(context).addedItems;
                  debugPrint(state.runtimeType.toString());
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primaryColorBlue,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                            )
                          ]),
                      child: getIt.get<AddItemCubit>().addedItems.isEmpty
                          ? TextBuilder(
                              AppLocalizations.of(context)!.no_items_added,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )
                          : ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return SelectedItem(
                                  itemModel: items[index],
                                );
                              },
                            ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

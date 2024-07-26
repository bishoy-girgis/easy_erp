import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../data/models/item_model/item_model.dart';
import '../../../../../../data/services/local/shared_pref.dart';
import '../../../../../cubits/item_cubit/item_cubit.dart';
import '../../add_items_view/widgets/item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandscapeInvoiceItems extends StatefulWidget {
   const LandscapeInvoiceItems({super.key});

  @override
  State<LandscapeInvoiceItems> createState() => _LandscapeInvoiceItemsState();
}

class _LandscapeInvoiceItemsState extends State<LandscapeInvoiceItems> {
  late List<ItemModel> searchForItems;

  TextEditingController searchController = TextEditingController();

  late List<ItemModel> allItems = [];

  Widget buildCubitWidget() {
    return BlocBuilder<GetItemCubit, GetItemState>(
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
    );
  }

  Widget buildLoadedListWidgets() {
    return Center(
        child: Padding(
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
                prefixPressed: () {},
                suffixPressed: () {},
              ),
              const GapH(h: 1),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    color: AppColors.whiteColor,
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.1.r,
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
        ),);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height+0.5,child: buildCubitWidget());
  }
}

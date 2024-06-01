// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../cubits/addItem_cubit/add_item_cubit.dart';
import '../../../../cubits/item_cubit/item_cubit.dart';
import 'widgets/item_widget.dart';

class AddItemsView extends StatefulWidget {
  const AddItemsView({super.key});

  @override
  State<AddItemsView> createState() => _AddItemsViewState();
}

class _AddItemsViewState extends State<AddItemsView> {
  late List<ItemModel> items = [];

  late List<ItemModel> searchForItems;
  TextEditingController searchController = TextEditingController();

  Widget buildCubitWidget() {
    return BlocBuilder<GetItemCubit, GetItemState>(
      builder: (context, state) {
        debugPrint("${SharedPref.get(key: "ReturnSelectedId")}");
        if (state is GetItemsSuccessState) {
          items = state.items;
          debugPrint("${items.length} length list");
          return buildLoadedListWidgets();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.select_items,
          color: AppColors.whiteColor,
        ),
        leading: IconButton(
          onPressed: () {
            GlobalMethods.showAlertAddressDialog(
              context,
              title: "Exit and dont save ? ",
              titleButton1: "YES",
              onPressedButton1: () {
                SharedPref.remove(key: "ReturnSelectedId");
                BlocProvider.of<AddItemCubit>(context).removeAllItems();
                for (int i = 0; i < items.length; i++) {
                  items[i].quantity = 1;
                }
                GlobalMethods.goRouterNavigateTOAndReplacement(
                    context: context, router: AppRouters.kHome);
              },
              titleButton2: "NO",
              onPressedButton2: () {
                GlobalMethods.navigatePOP(context);
              },
            );
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AddItemCubit>(context).checkAndMergeDuplicates();
              GlobalMethods.goRouterPOP(context);
            },
            icon: const Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: buildCubitWidget(),
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
              searchForItems = items
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
                  childAspectRatio: 0.43.r,
                ),
                itemCount: searchController.text.isEmpty
                    ? items.length
                    : searchForItems.length,
                itemBuilder: (context, index) {
                  return AddItemWidget(
                    itemModel: searchController.text.isEmpty
                        ? items[index]
                        : searchForItems[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}

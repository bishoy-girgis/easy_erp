// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter/material.dart';

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/invoice_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../data/models/item_model/item_model.dart';
import 'widgets/Invoice-main_data_section.dart';
import 'widgets/selected_item.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(
          "Create Invoice",
          isHeader: true,
          color: AppColors.whiteColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(slivers: [
            const InvoiceMainDataSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            PricingSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            SelectedItemsToInvoice(
              items: [],
            )
          ]),
        ),
      ),
    );
  }
}

class SelectedItemsToInvoice extends StatelessWidget {
  final List<ItemModel> items;
  const SelectedItemsToInvoice({
    Key? key,
    required this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocConsumer<AddItemCubit, AddItemState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var items;
          items = state is AddItemAddedSuccess
              ? BlocProvider.of<AddItemCubit>(context).addedItems
              : BlocProvider.of<AddItemCubit>(context).addedItems;
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: items.length == 0
                ? TextBuilder("No items selected")
                : Column(
                    children: [
                      SelectedItem(itemModel: items[0]),
                      SelectedItem(itemModel: items[1]),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class PricingSection extends StatelessWidget {
  const PricingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            CustomElevatedButton(
              backgroundColor: Colors.white,
              borderColor: Colors.blueGrey,
              hasBorder: true,
              borderWidth: 2,
              title: const TextBuilder(
                "Sellect Items",
                isHeader: true,
                color: Colors.black,
              ),
              onPressed: () {
                GlobalMethods.goRouterNavigateTO(
                    context: context, router: AppRouters.kAddItemsIntoInvoice);
              },
            ),
            GapH(h: 1),
            TextBuilder(
              "Total includes tax",
              color: Colors.black,
            ),
            GapH(h: 1),
            TextBuilder(
              "87777.85",
              fontSize: 40,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    TextBuilder(
                      "Amount before tax",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      "10.5",
                      color: Colors.black,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextBuilder(
                      "Tax amount",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    TextBuilder(
                      "10.5",
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

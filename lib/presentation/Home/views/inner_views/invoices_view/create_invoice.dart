// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_erp/core/helper/locator.dart';
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
import 'widgets/pricing_section.dart';
import 'widgets/selected_item.dart';
import 'widgets/selected_items_to_invoice.dart';

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
          padding: const EdgeInsets.all(14),
          child: CustomScrollView(slivers: [
            const InvoiceMainDataSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            PricingSection(),
            const SliverToBoxAdapter(
              child: GapH(h: 1),
            ),
            BlocBuilder<AddItemCubit, AddItemState>(builder: (context, state) {
              print(state.runtimeType);
              return getIt.get<AddItemCubit>().addedItems.length == 0
                  ? SliverToBoxAdapter(
                      child: Card(
                          elevation: 5,
                          child: TextBuilder(
                            "No items added",
                            textAlign: TextAlign.center,
                          )),
                    )
                  : SelectedItemsToInvoice(
                      items: BlocProvider.of<AddItemCubit>(context).addedItems,
                    );
            })
          ]),
        ),
      ),
    );
  }
}

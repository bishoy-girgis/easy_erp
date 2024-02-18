import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/invoice_cubit/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/Invoice-main_data_section.dart';
import 'widgets/pricing_section.dart';
import 'widgets/selected_items_to_invoice.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildCreateInvoiceBody(),
    );
  }

  SafeArea _buildCreateInvoiceBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(slivers: [
          InvoiceMainDataSection(),
          const SliverToBoxAdapter(
            child: GapH(h: 1),
          ),
          BlocBuilder<AddItemCubit, AddItemState>(
            builder: (context, state) {
              return PricingSection(
                  items: BlocProvider.of<AddItemCubit>(context).addedItems);
            },
          ),
          const SliverToBoxAdapter(child: GapH(h: 1)),
          BlocBuilder<AddItemCubit, AddItemState>(builder: (context, state) {
            debugPrint(state.runtimeType.toString());
            return getIt.get<AddItemCubit>().addedItems.isEmpty
                ? SliverToBoxAdapter(
                    child: Card(
                        elevation: 5,
                        child: TextBuilder(
                          AppLocalizations.of(context)!.no_items_added,
                          textAlign: TextAlign.center,
                        )),
                  )
                : SelectedItemsToInvoice(
                    items: BlocProvider.of<AddItemCubit>(context).addedItems,
                  );
          })
        ]),
      ),
    );
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.create_invoice,
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      actions: [
        BlocBuilder<InvoiceCubit, InvoiceState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                GlobalMethods.showAlertAdressDialog(
                  context,
                  title: "Save Invoice ? ",
                  titleButton1: "Save",
                  titleButton2: "No",
                  onPressedButton1: () async {
                    var s = await context.read<InvoiceCubit>().saveInvoice(
                          date: '02/08/2024',
                          custid: 1,
                          invtype: 0,
                          user: 'mostafa',
                          whid: 2,
                          ccid: 1,
                          branchid: 1,
                          netvalue: 20.00,
                          taxAdd: 20.00,
                          finalValue: 20.00,
                          payid: 1,
                          bankDtlId: 1,
                          itms:
                              BlocProvider.of<AddItemCubit>(context).addedItems,
                        );
                    print(s.toString());
                    print("ssssssssssssssssssssss");
                    print(s.toString());
                    if (state is InvoiceSavedSuccess) {
                      print(state.sendInvoiceModel);
                    } else if (state is InvoiceNotSave) {
                      print(state.error.toString());
                    }
                  },
                  onPressedButton2: () {
                    GlobalMethods.navigatePOP(context);
                  },
                );
              },
              icon: Icon(
                Icons.done,
              ),
            );
          },
        ),
      ],
    );
  }
}

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
            var items = getIt.get<AddItemCubit>().addedItems;
            return IconButton(
              onPressed: () async {
                GlobalMethods.showAlertAdressDialog(
                  context,
                  title: "Save Invoice ? ",
                  titleButton1: "Save",
                  titleButton2: "No",
                  onPressedButton1: () async {
                    getIt.get<AddItemCubit>().addedItems.isNotEmpty
                        ? await BlocProvider.of<InvoiceCubit>(context)
                            .saveInvoice(
                            bankDtlId: 1,
                            branchid: 1,
                            ccid: 1,
                            custid: 1,
                            date: DateTime.now(),
                            finalValue: 30,
                            invtype: 2,
                            netvalue: 30,
                            payid: 1,
                            taxAdd: 20,
                            whid: 1,
                            user: SharedPref.get(key: 'userName'),
                            itms: getIt.get<AddItemCubit>().addedItems,
                          )
                        : {
                            GlobalMethods.navigatePOP(context),
                            GlobalMethods.buildFlutterToast(
                              message:
                                  "You should select items to save invoice",
                              state: ToastStates.ERROR,
                            ),
                          };
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

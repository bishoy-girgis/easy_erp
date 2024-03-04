import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/Invoice-main_data_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/selected_items_to_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/widgets/return_main_data.dart';
import 'package:easy_erp/presentation/cubits/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateReturnView extends StatelessWidget {
  const CreateReturnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildCreateInvoiceBody(),
    );
  }

  SafeArea _buildCreateInvoiceBody() {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        ReturnMainDataWidget(),
        const SliverToBoxAdapter(
          child: GapH(h: 1),
        ),
        // BlocBuilder<AddItemCubit, AddItemState>(
        //   builder: (context, state) {
        //     return PricingSection(
        //         items: BlocProvider.of<AddItemCubit>(context).addedItems);
        //   },
        // ),
        // const SliverToBoxAdapter(child: GapH(h: 1)),
        // BlocBuilder<AddItemCubit, AddItemState>(builder: (context, state) {
        //   debugPrint(state.runtimeType.toString());
        //   return getIt.get<AddItemCubit>().addedItems.isEmpty
        //       ? SliverToBoxAdapter(
        //           child: Card(
        //               elevation: 5,
        //               child: TextBuilder(
        //                 AppLocalizations.of(context)!.no_items_added,
        //                 textAlign: TextAlign.center,
        //               )),
        //         )
        //       : SelectedItemsToInvoice(
        //           items: BlocProvider.of<AddItemCubit>(context).addedItems,
        //         );
        // })
      ],
    ));
  }

  AppBar _buildAppBar(context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.createReturn,
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      leading: IconButton(
          onPressed: () {
            GlobalMethods.navigatePOP(context);
            // getIt.get<AddItemCubit>().addedItems.isNotEmpty
            //     ? GlobalMethods.showAlertAdressDialog(
            //         context,
            //         title: "Are you sure to remove invoice ?",
            //         titleButton1: "yes",
            //         titleButton2: "No",
            //         onPressedButton1: () {
            //           GlobalMethods.goRouterNavigateTOAndReplacement(
            //               context: context, router: AppRouters.kInvoices);
            //           getIt.get<AddItemCubit>().addedItems.clear();
            //         },
            //         onPressedButton2: () {
            //           GlobalMethods.navigatePOP(context);
            //         },
            //       )
            //     : GlobalMethods.navigatePOP(context);
          },
          icon: Icon(Icons.arrow_back)),
      actions: [
        IconButton(
          onPressed: () async {
            // checkCustomer();
            // checkItems();
            // checkCustomer() && checkItems() && checkPaymentTypes()
            //     ? GlobalMethods.showAlertAdressDialog(
            //         context,
            //         title: "Save Invoice ?",
            //         titleButton1: "Save",
            //         titleButton2: "No",
            //         onPressedButton1: () async {
            //           await BlocProvider.of<InvoiceCubit>(context)
            //               .saveInvoice(
            //             items: getIt.get<AddItemCubit>().addedItems,
            //           );
            //         },
            //         onPressedButton2: () {
            //           GlobalMethods.navigatePOP(context);
            //         },
            //       )
            //     : Container();
          },
          icon: const Icon(
            Icons.done,
          ),
        )
      ],
    );
  }
}

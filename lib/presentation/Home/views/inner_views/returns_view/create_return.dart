import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/helper/pdf_helper.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/Invoice-main_data_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/selected_items_to_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/widgets/return_main_data.dart';
import 'package:easy_erp/presentation/cubits/addItem_cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
            SharedPref.remove(key: "ReturnSelectedId");
            SharedPref.remove(key: "withInvoiceSelected");
            getIt.get<AddItemCubit>().addedItems.clear();
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
        BlocConsumer<Returncubit, ReturnState>(
          listener: (context, state) {
            if (state is ReturnSavedSuccess) {
              debugPrint("=============================");
              debugPrint(state.sendInvoiceModel.massage);
              GlobalMethods.buildFlutterToast(
                  message: state.sendInvoiceModel.massage!,
                  state: ToastStates.SUCCESS);
              InvoiceCubit.get(context).getInvoices();
              GlobalMethods.goRouterNavigateTOAndReplacement(
                  context: context, router: AppRouters.kReturns);
              generateAndPrintArabicPdf(context,
                  qrData: state.sendInvoiceModel.qr ?? "",
                  invoTime: SharedPref.get(key: 'invoiceTime') ??
                      DateFormat('h:mm a').format(DateTime.now()),
                  invNo: state.sendInvoiceModel.invno,
                  netvalue: SharedPref.get(key: 'amountBeforeTex'),
                  taxAdd: SharedPref.get(key: 'taxAmount'),
                  finalValue: SharedPref.get(key: 'totalAmount'),
                  custName: SharedPref.get(key: 'custName') ?? 'cash',
                  invoDate: SharedPref.get(key: 'invoiceDate') ??
                      DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  invoiceType: "فاتورة ضريبية مبسطة",
                  items: getIt.get<AddItemCubit>().addedItems);
            } else if (state is ReturnNotSave) {
              GlobalMethods.navigatePOP(context);
              GlobalMethods.buildFlutterToast(
                  message: state.error, state: ToastStates.ERROR);
              debugPrint(state.error);
            } else {
              debugPrint("=============================");
              debugPrint('Dont Know');
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                // checkCustomer();
                // checkItems();
                GlobalMethods.showAlertAdressDialog(
                  context,
                  title: "Save Invoice ?",
                  titleButton1: "Save",
                  titleButton2: "No",
                  onPressedButton1: () async {
                    await BlocProvider.of<Returncubit>(context).saveReturn(
                      items: getIt.get<AddItemCubit>().addedItems,
                    );
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

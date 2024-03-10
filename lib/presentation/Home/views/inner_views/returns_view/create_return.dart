import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/helper/pdf_helper.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pricing_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/selected_items_to_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/widgets/return_main_data.dart';
import 'package:easy_erp/presentation/cubits/addItem_cubit/add_item_cubit.dart';
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
        const ReturnMainDataWidget(),
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

  bool checkCustomer() {
    if ((SharedPref.get(key: 'custID') == null ||
            SharedPref.get(key: 'custID') == 0)
        // && (SharedPref.get(key: 'invoiceTypeID')) == 2
        ) {
      GlobalMethods.buildFlutterToast(
          message: 'Cant save invoice  please choose your Customer to Save',
          state: ToastStates.ERROR);
      return false;
    }
    return true;
  }

  bool checkItems() {
    if (getIt.get<AddItemCubit>().addedItems.isEmpty) {
      GlobalMethods.buildFlutterToast(
          message: 'Cant save invoice please choose your Items to Save',
          state: ToastStates.ERROR);
      return false;
    }

    return true;
  }

  bool checkPaymentTypes() {
    if (SharedPref.get(key: 'paymentTypeID') == null ||
        SharedPref.get(key: 'paymentTypeID') == 0) {
      GlobalMethods.buildFlutterToast(
        message: 'Check your Payment Type',
        state: ToastStates.ERROR,
      );
      return false;
    }

    return true;
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
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        BlocConsumer<Returncubit, ReturnState>(
          listener: (context, state) {
            if (state is ReturnSavedSuccess) {
              debugPrint("=============================");
              debugPrint(state.sendInvoiceModel.massage);
              debugPrint("${state.sendInvoiceModel.invno}");
              GlobalMethods.buildFlutterToast(
                  message: state.sendInvoiceModel.massage!,
                  state: ToastStates.SUCCESS);
              Returncubit.get(context).getReturns();

              GlobalMethods.goRouterNavigateTOAndReplacement(
                  context: context, router: AppRouters.kReturns);
              generateAndPrintArabicPdf(context,
                  isReturn: true,
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
                  invoiceType: "مرتجع ضريبي مبسط",
                  items: getIt.get<AddItemCubit>().addedItems);
              SharedPref.remove(key: "ReturnSelectedId");
              SharedPref.remove(key: "withInvoiceSelected");
              getIt.get<AddItemCubit>().addedItems.clear();
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
                checkCustomer() && checkItems() && checkPaymentTypes()
                    ? GlobalMethods.showAlertAdressDialog(
                        context,
                        title: "Save Return ?",
                        titleButton1: "Save",
                        titleButton2: "No",
                        onPressedButton1: () async {
                          await BlocProvider.of<Returncubit>(context)
                              .saveReturn(
                                  items: getIt.get<AddItemCubit>().addedItems,
                                  invid:
                                      SharedPref.get(key: "ReturnSelectedId") ??
                                          0);
                        },
                        onPressedButton2: () {
                          GlobalMethods.navigatePOP(context);
                        },
                      )
                    : Container();
              },
              icon: const Icon(
                Icons.done,
              ),
            );
          },
        ),
      ],
    );
  }
}

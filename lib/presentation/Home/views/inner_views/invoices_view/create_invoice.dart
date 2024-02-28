import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helper/pdf_helper.dart';
import '../../../../cubits/addItem_cubit/cubit/add_item_cubit.dart';
import '../../../../cubits/invoice_cubit/cubit/invoice_cubit.dart';
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
    // String getCustomerName() {
    //   for (var cust in CustomerCubit.get(context).customers) {
    //     if (cust.custid == 0) {
    //       return 'Cash';
    //     } else if (cust.custid == SharedPref.get(key: 'custID')) {
    //       print(cust.custname ?? cust.custename ?? "");
    //       print(cust.custname ?? cust.custename ?? "");
    //       print(cust.custname ?? cust.custename ?? "");
    //       print(cust.custname ?? cust.custename ?? "");
    //       return cust.custname ?? cust.custename ?? "";
    //     }
    //   }
    //   return "nine";
    // }
    bool checkCustomer() {
      if ((SharedPref.get(key: 'custID') == null ||
              SharedPref.get(key: 'custID') == 0) &&
          (SharedPref.get(key: 'invoiceTypeID')) == 2) {
        GlobalMethods.buildFlutterToast(
            message:
                'Cant save invoice  please choose your invoice type and Customer to Save',
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

    return AppBar(
      leading: IconButton(
          onPressed: () {
            getIt.get<AddItemCubit>().addedItems.isNotEmpty
                ? GlobalMethods.showAlertAdressDialog(
                    context,
                    title: "Are you sure to remove invoice ?",
                    titleButton1: "yes",
                    titleButton2: "No",
                    onPressedButton1: () {
                      GlobalMethods.goRouterNavigateTOAndReplacement(
                          context: context, router: AppRouters.kInvoices);
                      getIt.get<AddItemCubit>().addedItems.clear();
                    },
                    onPressedButton2: () {
                      GlobalMethods.navigatePOP(context);
                    },
                  )
                : GlobalMethods.navigatePOP(context);
          },
          icon: Icon(Icons.arrow_back)),
      title: TextBuilder(
        AppLocalizations.of(context)!.create_invoice,
        isHeader: true,
        color: AppColors.whiteColor,
      ),
      actions: [
        BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceSavedSuccess) {
              debugPrint("=============================");
              debugPrint(state.sendInvoiceModel.massage);
              GlobalMethods.buildFlutterToast(
                  message: state.sendInvoiceModel.massage!,
                  state: ToastStates.SUCCESS);
              InvoiceCubit.get(context).getInvoices();
              final itemBox = Hive.box<ItemModel>('itemBox');
              itemBox.addAll(getIt.get<AddItemCubit>().addedItems);
              GlobalMethods.goRouterNavigateTOAndReplacement(
                  context: context, router: AppRouters.kInvoices);
              generateAndPrintArabicPdf(context,
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
            } else if (state is InvoiceNotSave) {
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
                checkCustomer() && checkItems() && checkPaymentTypes()
                    ? GlobalMethods.showAlertAdressDialog(
                        context,
                        title: "Save Invoice ?",
                        titleButton1: "Save",
                        titleButton2: "No",
                        onPressedButton1: () async {
                          await BlocProvider.of<InvoiceCubit>(context)
                              .saveInvoice(
                            items: getIt.get<AddItemCubit>().addedItems,
                          );
                        },
                        onPressedButton2: () {
                          GlobalMethods.navigatePOP(context);
                        },
                      )
                    : Container();
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

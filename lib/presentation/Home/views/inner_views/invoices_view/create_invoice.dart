import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/landscape/Landscape_Invoice_maindata.dart.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/landscape/landscape_invoice_items.dart';
import 'package:flutter/material.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helper/pdf_helper.dart';
import '../../../../cubits/addItem_cubit/add_item_cubit.dart';
import '../../../../cubits/invoice_cubit/invoice_cubit.dart';
import '../../../../cubits/item_cubit/item_cubit.dart';
import 'landscape/landscape_pricing_section.dart';
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
      body: GlobalMethods.isLandscape(context)
          ? _landScapeInvoiceBody()
          : _buildCreateInvoiceBody(),
    );
  }
  SafeArea _landScapeInvoiceBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            LandscapeInvoiceMainDataSection(),
            const SliverToBoxAdapter(child: GapH(h: 1)),
            const LandscapeInvoiceItems(),
            const SliverToBoxAdapter(child: GapH(h: 1)),
            BlocBuilder<AddItemCubit, AddItemState>(
              builder: (context, state) {
                return LandScapePricingSection(
                  items: BlocProvider.of<AddItemCubit>(context).addedItems,
                );
              },
            ),
            const SliverToBoxAdapter(child: GapH(h: 1)),
          ],
        ),
      ),
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
            message: AppLocalizations.of(context)!.chooseInvoice,
            state: ToastStates.ERROR);
        return false;
      }
      return true;
    }

    bool checkItems() {
      if (getIt.get<AddItemCubit>().addedItems.isEmpty) {
        GlobalMethods.buildFlutterToast(
            message: AppLocalizations.of(context)!.chooseItem,
            state: ToastStates.ERROR);
        return false;
      }

      return true;
    }

    bool checkPaymentTypes() {
      if (SharedPref.get(key: 'invoiceTypeID') == 2) {
        return true;
      } else {
        if (SharedPref.get(key: 'paymentTypeID') == null ||
            SharedPref.get(key: 'paymentTypeID') == 0) {
          GlobalMethods.buildFlutterToast(
            message: AppLocalizations.of(context)!.checkPayment,
            state: ToastStates.ERROR,
          );
          return false;
        }
      }
      return true;
    }

    return AppBar(
      leading: IconButton(
          onPressed: () {
            getIt.get<AddItemCubit>().addedItems.isNotEmpty
                ? GlobalMethods.showAlertAddressDialog(
                    context,
                    title: AppLocalizations.of(context)!.removeInvoice,
                    titleButton1: AppLocalizations.of(context)!.yes,
                    titleButton2: AppLocalizations.of(context)!.no,
                    onPressedButton1: () {
                      GlobalMethods.goRouterNavigateTOAndReplacement(
                          context: context, router: AppRouters.kInvoices);
                      getIt.get<AddItemCubit>().addedItems.clear();
                      InvoiceCubit.get(context).getInvoices();
                    },
                    onPressedButton2: () {
                      GlobalMethods.navigatePOP(context);
                    },
                  )
                : GlobalMethods.navigatePOP(context);
          },
          icon: const Icon(Icons.arrow_back)),
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
            } else if (state is InvoiceNotSave) {
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
                    ? GlobalMethods.showAlertAddressDialog(
                        context,
                        title: AppLocalizations.of(context)!.saveInvoice,
                        titleButton1: AppLocalizations.of(context)!.yes,
                        titleButton2: AppLocalizations.of(context)!.no,
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

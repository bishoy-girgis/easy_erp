import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/preview.dart';
import 'package:flutter/material.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/pdf_helper.dart';
import '../../../../../data/cubits/addItem_cubit/cubit/add_item_cubit.dart';
import '../../../../../data/cubits/invoice_cubit/cubit/invoice_cubit.dart';
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
        BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceSavedSuccess) {
              print(state.sendInvoiceModel);
              print("=============================");
              print(state.sendInvoiceModel.massage);
              GlobalMethods.buildFlutterToast(
                  message: state.sendInvoiceModel.massage!,
                  state: ToastStates.SUCCESS);
              InvoiceCubit.get(context).getInvoices();

              var items = getIt.get<AddItemCubit>().addedItems;
              print(items);
              generateAndPrintArabicPdf(context,
                  invoiceModel: InvoiceModel(custInvname: "Yusuf"),
                  invoiceType: "فاتورة مبسطة",
                  items: items);
              getIt.get<AddItemCubit>().addedItems.clear();
            } else if (state is InvoiceNotSave) {
              GlobalMethods.navigatePOP(context);
              GlobalMethods.buildFlutterToast(
                  message: state.error, state: ToastStates.ERROR);
              print(state.error);
            } else {
              print("=============================");
              print('Dont Know');
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                GlobalMethods.showAlertAdressDialog(
                  context,
                  title: "Save Invoice ?",
                  titleButton1: "Save",
                  titleButton2: "No",
                  onPressedButton1: () async {
                    var items = getIt.get<AddItemCubit>().addedItems;
                    print('Items in On pressed : ' + items.toString());

                    if ((SharedPref.get(key: 'custID') == null ||
                            SharedPref.get(key: 'custID') == 0) &&
                        (SharedPref.get(key: 'invoiceTypeID')) == 2) {
                      GlobalMethods.navigatePOP(context);
                      GlobalMethods.buildFlutterToast(
                          message:
                              'Cant save invoice  please choose your invoice type and Customer to Save',
                          state: ToastStates.ERROR);
                      return;
                    } else if (getIt.get<AddItemCubit>().addedItems.isEmpty) {
                      GlobalMethods.navigatePOP(context);
                      GlobalMethods.buildFlutterToast(
                          message:
                              'Cant save invoice please choose your Items to Save',
                          state: ToastStates.ERROR);
                    } else {
                      await BlocProvider.of<InvoiceCubit>(context).saveInvoice(
                        items: items,
                      );
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

// ignore_for_file: use_build_context_synchronously

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/invoice_widget.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/global_methods.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/shimmer_invoice_widget.dart';
import '../../../../../data/models/invoice_model/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../cubits/invoice_cubit/invoice_cubit.dart';

class InvoicesView extends StatefulWidget {
  const InvoicesView({Key? key}) : super(key: key);

  @override
  State<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends State<InvoicesView> {
  List<InvoiceModel> invoices = [];

  List<InvoiceModel> searchForInvoices = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await GetItemCubit.get(context).getItems();
          await PaymentTypeCubit.get(context).getPaymentTypes();
          GlobalMethods.navigateTo(
            context,
            const CreateInvoiceView(),
          );
        },
        elevation: 10,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.invoises.toLowerCase(),
          isHeader: true,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText:AppLocalizations.of(context)!.search,
              hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
              suffixIcon: Icons.search,
              backgroundOfTextFeild: Colors.white,
              onChange: (v) {
                searchController.text = v;
                searchForInvoices = invoices
                    .where((invoice) =>
                        invoice.custInvname!.toLowerCase().contains(v) ||
                        invoice.invNo!.toLowerCase().startsWith(v) ||
                        invoice.invdate!.toString().startsWith(v))
                    .toList();
                setState(() {});
              },
            ),
            const GapH(h: 1),
            BlocConsumer<InvoiceCubit, InvoiceState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetInvoiceSuccess) {
                  invoices = state.invoiceModels;
                  return Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.whiteColor,
                    ),
                    child: ListView.builder(
                        // reverse: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        itemCount: searchForInvoices.isNotEmpty
                            ? searchForInvoices.length
                            : state.invoiceModels.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              InvoiceCubit.get(context).getInvoiceDataAndItems(
                                context,
                                invNo: searchForInvoices.isNotEmpty
                                    ? searchForInvoices[index].invNo!
                                    : state.invoiceModels[index].invNo!,
                              );
                            },
                            child: InvoiceWidget(
                              invoiceModel: searchForInvoices.isNotEmpty
                                  ? searchForInvoices[index]
                                  : state.invoiceModels[index],
                            ),
                          );
                        }),
                  ));
                } else if (state is GetInvoiceFailure) {
                  debugPrint(state.error);
                  return const Center(
                    child: TextBuilder(
                        "Sorry there is error , we will work on it "),
                  );
                } else if (state is GetInvoiceLoading) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.whiteColor,
                      ),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const ShimmerInvoiceWidget();
                          }),
                    ),
                  );
                } else{
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

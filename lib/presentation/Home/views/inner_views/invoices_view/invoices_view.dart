import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/invoice_cubit/cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/invoice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/global_methods.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../data/models/invoice_model/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoicesView extends StatefulWidget {
  InvoicesView({Key? key}) : super(key: key);

  @override
  State<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends State<InvoicesView> {
  List<InvoiceModel> invoices = [];

  List<InvoiceModel> searchForInvoices = [];

  TextEditingController searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: AppLocalizations.of(context)!.search,
              // hintText: "Search with Customer name",
              suffixIcon: Icons.search,
              backgroundOfTextFeild: Colors.white,
              onChange: (v) {
                searchController.text = v;
                searchForInvoices = invoices
                    .where((invoice) =>
                        invoice.custInvname!.toLowerCase().startsWith(v) ||
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        itemCount: searchForInvoices.isNotEmpty
                            ? searchForInvoices.length
                            : state.invoiceModels.length,
                        itemBuilder: (context, index) {
                          return InvoiceWidget(
                            invoiceModel: searchForInvoices.isNotEmpty
                                ? searchForInvoices[index]
                                : state.invoiceModels[index],
                          );
                        }),
                  ));
                } else if (state is GetInvoiceFailure) {
                  debugPrint(state.error);
                  return Center(
                    child: TextBuilder(
                        "Sorry there is error , we will work on it "),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
  // Widget buildCubitWidget() {
  //   return BlocBuilder<InvoiceCubit, InvoiceState>(
  //     builder: (context, state) {
  //       if (state is GetInvoiceSuccess) {
  //         InvoiceCubit.get(context).getInvoices();
  //         invoices = state.invoiceModels;

  //         return _buildBody();
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }

  // // final invoiceModels = <InvoiceModel>[
  // //   InvoiceModel(
  // //     finalValue: 1,
  // //     invtype: 1,
  // //     netvalue: 1,
  // //     taxAdd: 1,
  // //     custInvname: "ddddddd",
  // //   ),
  // // ];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: _buildAppBar(context),
  //     body: _buildBody(),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         GlobalMethods.navigateTo(
  //           context,
  //           CreateInvoiceView(),
  //         );
  //       },
  //       elevation: 10,
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  // }

  // /// AppBar
  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: TextBuilder(
  //       AppLocalizations.of(context)!.invoises.toLowerCase(),
  //       isHeader: true,
  //       color: Colors.white,
  //     ),
  //     foregroundColor: Colors.white,
  //     actions: [
  //       IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             Icons.add_box,
  //           ))
  //     ],
  //   );
  // }

  // /// Body
  // Widget _buildBody() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Column(
  //       children: [
  //         CustomTextFormField(
  //           labelText: AppLocalizations.of(context)!.search,
  //           hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
  //           suffixIcon: Icons.search,
  //           controller: searchController,
  //           prefixIcon: Icons.qr_code_rounded,
  //           backgroundOfTextFeild: Colors.white,
  //           onChange: (v) {
  //             searchController.text = v;
  //             searchForInvoices = invoices
  //                 .where((invoice) =>
  //                     invoice.custInvname!.toLowerCase().startsWith(v) ||
  //                     invoice.invNo!.toString().startsWith(v))
  //                 .toList();
  //             setState(() {});
  //           },
  //         ),
  //         // InvoiceWidget(),
  //         Flexible(
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10),
  //             decoration: BoxDecoration(
  //               color: AppColors.whiteColor,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: ListView(
  //               // itemCount: searchController.text.isEmpty
  //               //     ? invoices.length
  //               //     : searchForInvoices.length,
  //               // itemBuilder: (context, index) {
  //               //   return InvoiceWidget(
  //               //     invoiceModel: searchController.text.isEmpty
  //               //         ? invoices[index]
  //               //         : searchForInvoices[index],
  //               //   );
  //               // },
  //               children: [
  //                 ...invoices
  //                     .map(
  //                       (invoice) => InvoiceWidget(invoiceModel: invoice),
  //                     )
  //                     .toList(),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

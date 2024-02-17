import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/invoice_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/global_methods.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../data/models/invoice_model/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoicesView extends StatelessWidget {
  InvoicesView({Key? key}) : super(key: key);

  final invoiceModels = <InvoiceModel>[
    InvoiceModel(
      finalValue: 1,
      invtype: 1,
      netvalue: 1,
      taxAdd: 1,
      custInvname: "ddddddd",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalMethods.navigateTo(
            context,
            CreateInvoiceView(),
          );
        },
        elevation: 10,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.invoises.toLowerCase(),
        isHeader: true,
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_box,
            ))
      ],
    );
  }

  /// Body
  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CustomTextFormField(
            labelText: AppLocalizations.of(context)!.search.toString(),
            hintText: AppLocalizations.of(context)!
                .search_with_id_code_barcode
                .toString(),
            suffixIcon: Icons.search,
            prefixIcon: Icons.qr_code_rounded,
            prefixPressed: () {},
            suffixPressed: () {},
          ),
          // InvoiceWidget(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  ...invoiceModels.map((invoiceModel) => InvoiceWidget(
                        invoiceModel: invoiceModel,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/preview.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/invoice_model/invoice_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceDetailsView extends StatelessWidget {
  final InvoiceModel singleInvoiceItem;
  const InvoiceDetailsView({
    Key? key,
    required this.singleInvoiceItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(context),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  /// Body
  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextBuilder(
                    AppLocalizations.of(context)!.customer + ' :',
                    fontSize: 20,
                  ),
                  TextBuilder(
                    singleInvoiceItem.custInvname!,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    TextBuilder(
                      'Invoice Details',
                      fontSize: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextBuilder(
                          AppLocalizations.of(context)!.total,
                          fontSize: 25,
                        ),
                        TextBuilder(
                          "${singleInvoiceItem.finalValue}",
                          fontSize: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar(context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.invoises,
        color: AppColors.whiteColor,
        maxLines: 2,
      ),
    );
  }

  /// Floating Action Button
  Widget _fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                PdfPreviewPage(invoiceModel: singleInvoiceItem),
          ),
        );
        // rootBundle.
      },
      child: const Icon(Icons.picture_as_pdf),
    );
  }
}

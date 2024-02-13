import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/preview.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/invoice_model/invoice_model.dart';

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
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  /// Body
  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Customer',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  singleInvoiceItem.customer.custname!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Text(
                    'Bill Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ...singleInvoiceItem.items.map(
                    (item) => ListTile(
                      title: Text(item.itmname!),
                      trailing: Text(
                        item.salesprice!.toStringAsFixed(2),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headlineMedium,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Total"),
                        Text(
                          "\$${singleInvoiceItem.totalCost().toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        singleInvoiceItem.address,
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

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/invoice_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/global_methods.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../data/models/invoice_model/invoice_model.dart';
import 'details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoicesView extends StatelessWidget {
  InvoicesView({Key? key}) : super(key: key);

  final bills = <BillModel>[
    BillModel(
      customer: 'Alice Johnson',
      address: '456 Mock Ave\nWonderland',
      items: [
        LineItem('Consultation Services', 150),
        LineItem('Custom Software Development', 2500.75),
        LineItem('Training Session', 180),
      ],
      name: 'Software Consultation and Development',
    ),
    BillModel(
      customer: 'Bob Smith',
      address: '789 Fiction St\nNeverland',
      items: [
        LineItem('Graphic Design', 90),
        LineItem('Hosting Services', 120),
        LineItem('Mobile App Development', 3500.25),
      ],
      name: 'Design and Development Services',
    ),
    BillModel(
      customer: 'Eva Davis',
      address: '101 Fantasy Blvd\nDreamland',
      items: [
        LineItem('System Integration', 200),
        LineItem('Database Management', 300),
        LineItem('Content Creation', 180.50),
      ],
      name: 'Integrated Solutions Package',
    ),
    BillModel(
        customer: 'David Thomas',
        address: '123 Fake St\r\nBermuda Triangle',
        items: [
          LineItem(
            'Technical Engagement',
            120,
          ),
          LineItem('Deployment Assistance', 200),
          LineItem('Develop Software Solution', 3020.45),
          LineItem('Produce Documentation', 840.50),
        ],
        name: 'Create and deploy software package'),
    BillModel(
      customer: 'Charlie Brown',
      address: '321 Cartoon Lane\nToonville',
      items: [
        LineItem('Animation Services', 180),
        LineItem('Storyboarding', 120),
        LineItem('Character Design', 250.75),
      ],
      name: 'Animation and Design Package',
    ),
    BillModel(
      customer: 'Grace Miller',
      address: '567 Sci-Fi Blvd\nFuture City',
      items: [
        LineItem('Robotics Consultation', 300),
        LineItem('AI Programming', 500),
        LineItem('Virtual Reality Development', 1200.50),
      ],
      name: 'Future Tech Solutions',
    ),
    BillModel(
      customer: 'Frank Johnson',
      address: '876 Mystery St\nEnigma Town',
      items: [
        LineItem('Investigation Services', 150),
        LineItem('Surveillance Equipment', 200),
        LineItem('Evidence Analysis', 300.25),
      ],
      name: 'Private Investigation Package',
    ),
    BillModel(
      customer: 'Olivia Green',
      address: '432 Fairy Ave\nMagicland',
      items: [
        LineItem('Spell Casting Consultation', 100),
        LineItem('Enchantment Services', 180),
        LineItem('Magical Artifact Creation', 450.75),
      ],
      name: 'Magical Services Bundle',
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
        child: Icon(Icons.add),
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
            icon: Icon(
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
            labelText: "Search",
            hintText: "Search with ID , Code, or Barcode NO",
            suffixIcon: Icons.search,
            suffixColor: Colors.blueGrey,
            prefixIcon: Icons.qr_code_rounded,
            prefixIconColor: Colors.blueGrey,
            // backgroundOfTextFeild: Colors.white,
            prefixPressed: () {},
            suffixPressed: () {},
          ),
          // InvoiceWidget(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  ...bills.map((e) => InvoiceWidget(
                        e: e,
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

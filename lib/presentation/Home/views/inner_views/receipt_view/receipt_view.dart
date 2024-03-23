// ignore_for_file: use_build_context_synchronously

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/create_reciept.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/reciept_widget.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReceiptView extends StatefulWidget {
  const ReceiptView({super.key});

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await PayerTypeCubit.get(context).getPayerTypes(type: 1);
          print("Cheecckkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          await PaymentTypeCubit.get(context).getPaymentTypes();
          GlobalMethods.navigateTo(
            context,
            const CreateReciept(),
          );
        },
        elevation: 10,
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: TextBuilder(
        AppLocalizations.of(context)!.reciept_vouchers,
        isHeader: true,
        color: Colors.white,
      ),
    );
  }

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
            onChange: (v) {},
          ),
          // InvoiceWidget(),
          const GapH(h: 1),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.whiteColor,
            ),
            child: ListView.builder(
              // reverse: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemCount: 8,
              itemBuilder: (context, index) => const Recieptwidget(),
            ),
          ))
        ],
      ),
    );
  }
}

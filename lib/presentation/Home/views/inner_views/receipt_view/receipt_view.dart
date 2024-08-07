// ignore_for_file: use_build_context_synchronously

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/create_reciept.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/pdf_reciept.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/reciept_widget.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_cubit.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_states.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/shimmer_invoice_widget.dart';
import '../../../../../core/widgets/shimmer_item_widget.dart';

class ReceiptView extends StatefulWidget {
  const ReceiptView({super.key});

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  List<RecieptModel> reciepts = [];

  List<RecieptModel> searchForReciepts = [];

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PayerTypeCubit.get(context).getPayerTypes(type: 1);
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
      leading: IconButton(
          onPressed: () {
            GlobalMethods.goRouterNavigateTO(
                context: context, router: AppRouters.kHome);
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CustomTextFormField(
            labelText:AppLocalizations.of(context)!.search,
            hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
            suffixIcon: Icons.search,
            suffixColor: Colors.blueGrey,
            onChange: (v) {
              searchController.text = v;
              searchForReciepts = reciepts
                  .where((reciept) =>
                      reciept.cashinOrdno!.toString().startsWith(v) ||
                      reciept.cashinhdrId!.toString().startsWith(v) ||
                      reciept.custchartName!.toLowerCase().contains(v))
                  .toList();
              setState(() {});
            },
          ),
          // InvoiceWidget(),
          const GapH(h: 1),
          BlocConsumer<Recieptcubit, RecieptState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetRecieptSuccess) {
                reciepts = state.recieptModel;
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
                      itemCount: searchForReciepts.isNotEmpty
                          ? searchForReciepts.length
                          : state.recieptModel.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            RecieptModel reciept = searchForReciepts.isNotEmpty
                                ? searchForReciepts[index]
                                : state.recieptModel[index];
                            DateTime dateTime =
                                DateTime.parse(reciept.date ?? "1/1/2000");
                            String formattedDate =
                                "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

                            generatePdfReciept(context,
                                pdfType: " نسخه من سند قبض",
                                voucherNo: reciept.cashinOrdno.toString(),
                                voucherDate: formattedDate,
                                voucherTime: "00:00:00",
                                voucherValue: reciept.recvalue!,
                                voucherNotes: reciept.notes ?? "--",
                                payerName: reciept.custchartName!,
                                voucherPaymentType: reciept.payName!);
                          },
                          child: Recieptwidget(
                            recieptModel: searchForReciepts.isNotEmpty
                                ? searchForReciepts[index]
                                : state.recieptModel[index],
                          ),
                        );
                      }),
                ));
              } else if (state is GetRecieptFailure) {
                debugPrint(state.error);
                return const Center(
                  child:
                      TextBuilder("Sorry there is error , we will work on it "),
                );
              } else if (state is GetRecieptLoading){
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
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

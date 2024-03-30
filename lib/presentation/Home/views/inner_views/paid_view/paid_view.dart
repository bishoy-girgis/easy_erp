// ignore_for_file: use_build_context_synchronously

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/paid_model/paid_model.dart';
import 'package:easy_erp/data/models/reciept/reciept_model/reciept_paid_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/create_paid.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/widgets/paid_widget.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/widgets/pdf_reciept.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_cubit.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_states.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../cubits/payer_type_cubit/payer_type_cubit.dart';

class PaidView extends StatefulWidget {
  const PaidView({super.key});

  @override
  State<PaidView> createState() => _PaidViewState();
}

class _PaidViewState extends State<PaidView> {
  List<PaidModel> paids = [];

  List<PaidModel> searchForPaids = [];

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PayerTypeCubit.get(context).getPayerTypes(type: 2);
          await PaymentTypeCubit.get(context).getPaymentTypes();
          GlobalMethods.navigateTo(
            context,
            const CreatePaid(),
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
        AppLocalizations.of(context)!.paid_voucher,
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
            labelText: "Search",
            hintText: "Search with ID , Code, or Barcode NO",
            suffixIcon: Icons.search,
            suffixColor: Colors.blueGrey,
            onChange: (v) {
              searchController.text = v;
              searchForPaids = paids
                  .where((Paid) =>
                      Paid.cashoutOrdno!.toString().startsWith(v) ||
                      Paid.cashoutHdrid!.toString().startsWith(v) ||
                      Paid.paymentchartName!.toLowerCase().startsWith(v))
                  .toList();
              setState(() {});
            },
          ),
          const GapH(h: 1),
          BlocConsumer<Paidcubit, PaidState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetPaidSuccess) {
                paids = state.paidModel;
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
                      itemCount: searchForPaids.isNotEmpty
                          ? searchForPaids.length
                          : state.paidModel.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            PaidModel paid = searchForPaids.isNotEmpty
                                ? searchForPaids[index]
                                : state.paidModel[index];
                            DateTime dateTime =
                                DateTime.parse(paid.date ?? "1/1/2000");
                            String formattedDate =
                                "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

                            generatePdfReciept(context,
                                pdfType: "فاتوره سند صرف",
                                voucherNo: paid.cashoutOrdno.toString(),
                                voucherDate: formattedDate,
                                voucherTime: "00:00:00",
                                voucherValue: paid.payvalue!,
                                voucherNotes: paid.notes ?? "--",
                                payerName: paid.paymentchartName!,
                                vatValue: paid.vatvalue!,
                                voucherPaymentType: paid.payName!);
                          },
                          child: Paidwidget(
                            paidModel: searchForPaids.isNotEmpty
                                ? searchForPaids[index]
                                : state.paidModel[index],
                          ),
                        );
                      }),
                ));
              } else if (state is GetPaidFailure) {
                debugPrint(state.error);
                return const Center(
                  child:
                      TextBuilder("Sorry there is error , we will work on it "),
                );
              } else {
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

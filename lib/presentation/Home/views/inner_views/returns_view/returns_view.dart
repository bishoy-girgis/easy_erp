import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/shimmer_invoice_widget.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/return/return_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/create_return.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/widgets/return_widget.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/cubits/payment_type_cubit/payment_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReturnsView extends StatefulWidget {
  const ReturnsView({Key? key}) : super(key: key);

  @override
  State<ReturnsView> createState() => _ReturnsViewState();
}

class _ReturnsViewState extends State<ReturnsView> {
  List<ReturnModel> returns = [];

  List<ReturnModel> searchForReturnss = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PaymentTypeCubit.get(context).getPaymentTypes();
          InvoiceCubit.get(context).getInvoices();
          GlobalMethods.navigateTo(
            context,
            const CreateReturnView(),
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
        AppLocalizations.of(context)!.returns.toLowerCase(),
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
            labelText:AppLocalizations.of(context)!.search,
            hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
            suffixIcon: Icons.search,
            suffixColor: Colors.blueGrey,
            onChange: (v) {
              searchController.text = v;
              searchForReturnss = returns
                  // ignore: non_constant_identifier_names
                  .where((Return) =>
              Return.custname!.toLowerCase().contains(v) ||
                      Return.rtnInvNo!.toLowerCase().startsWith(v) ||
                      Return.invNo!.toLowerCase().startsWith(v) ||
                      Return.invid!.toString().startsWith(v))
                  .toList();
              setState(() {});
            },
          ),
          // InvoiceWidget(),
          const GapH(h: 1),
          BlocConsumer<ReturnCubit, ReturnState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetReturnSuccess || state is GetReturnDataSuccess) {
                returns = ReturnCubit.get(context).returns;
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
                      itemCount: searchForReturnss.isNotEmpty
                          ? searchForReturnss.length
                          : returns.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ReturnCubit.get(context).getReturnDataAndItems(
                              context,
                              returnInvNo: searchForReturnss.isNotEmpty
                                  ? searchForReturnss[index].rtnInvNo!
                                  : returns[index].rtnInvNo!,
                            );
                          },
                          child: ReturnWidget(
                            returnModel: searchForReturnss.isNotEmpty
                                ? searchForReturnss[index]
                                : returns[index],
                          ),
                        );
                      }),
                ));
              } else if (state is GetReturnFailure) {
                debugPrint(state.error);
                return const Center(
                  child:
                      TextBuilder("Sorry there is error , we will work on it "),
                );
              }else if(state is GetReturnLoading){
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

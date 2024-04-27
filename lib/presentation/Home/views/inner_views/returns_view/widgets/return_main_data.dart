import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/Invoice-main_data_section.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/pick_date_widget.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/widgets/sellect_cash_or_postpon_section.dart';
import 'package:easy_erp/presentation/cubits/addItem_cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReturnMainDataWidget extends StatefulWidget {
  const ReturnMainDataWidget({super.key});

  @override
  State<ReturnMainDataWidget> createState() => _ReturnMainDataWidgetState();
}

class _ReturnMainDataWidgetState extends State<ReturnMainDataWidget> {
  bool _isInvoiceSelected = false;
  List<InvoiceModel> invoices = [];
  InvoiceModel? selectedInvoice;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    debugPrint("${SharedPref.get(key: "withInvoiceSelected")}");
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chooseWithInvoiceOrNot(),
            _isInvoiceSelected
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBuilder(
                        AppLocalizations.of(context)!.invoice_number,
                        isHeader: true,
                        fontSize: 15,
                      ),
                      BlocBuilder<InvoiceCubit, InvoiceState>(
                        builder: (context, state) {
                          if (state is GetInvoiceLoading) {
                            // Show a loading indicator
                            return const CircularProgressIndicator();
                          } else if (state is GetInvoiceSuccess) {
                            // Use the data from state.invoices to populate your Autocomplete widget
                            return autoComplete(state.invoiceModels);
                          } else if (state is GetInvoiceFailure) {
                            // Show an error message
                            return Text(state.error);
                          } else {
                            // Handle other states if necessary
                            return const Text('check error ');
                          }
                        },
                      ),
                    ],
                  )
                : Container(),
            TextBuilder(
              AppLocalizations.of(context)!.return_id,
              isHeader: true,
              fontSize: 15,
            ),
            CustomTextFormField(
              contentSize: 14,
              labelText: AppLocalizations.of(context)!.auto,
              centerContent: true,
              isLabelBold: true,
              isClickable: false,
              // controller: invoiceIDController,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.return_date,
              isHeader: true,
              fontSize: 16,
            ),
            const Row(
              children: [
                Flexible(child: DatePickerWidget()),
                GapW(w: 1),
                Flexible(child: HoursAndMinutes()),
              ],
            ),
            SearchOnCustomerSection(
              labelText: AppLocalizations.of(context)!.customer,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.return_type,
              isHeader: true,
              fontSize: 16,
            ),
            const SellectCashOrCreditSection(),
          ],
        ),
      ),
    );
  }

  chooseWithInvoiceOrNot() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColorBlue, width: 2),
          borderRadius: BorderRadius.circular(8)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Container(
            color: _isInvoiceSelected ? AppColors.primaryColorBlue : null,
            child: TextButton(
              onPressed: () {
                getIt.get<InvoiceCubit>().getInvoices();
                if (getIt.get<AddItemCubit>().addedItems.isNotEmpty) {
                  getIt.get<AddItemCubit>().addedItems.clear();
                  GlobalMethods.navigatePOP(context);
                }
                setState(() {
                  _isInvoiceSelected = true;
                  SharedPref.set(key: "withInvoiceSelected", value: true);
                  debugPrint("${SharedPref.get(key: "withInvoiceSelected")}");
                });
              },
              child: TextBuilder(
                AppLocalizations.of(context)!.with_invoices,
                color: _isInvoiceSelected
                    ? Colors.white
                    : AppColors.primaryColorBlue,
                fontSize: 12,
              ),
            ),
          )),
          SizedBox(width: 5.w),
          Expanded(
              child: Container(
            color: !_isInvoiceSelected ? AppColors.primaryColorBlue : null,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isInvoiceSelected = false;
                  SharedPref.set(key: "withInvoiceSelected", value: false);
                  debugPrint("${SharedPref.get(key: "withInvoiceSelected")}");
                });
              },
              child: TextBuilder(
                AppLocalizations.of(context)!.without_invoice,
                color: !_isInvoiceSelected
                    ? Colors.white
                    : AppColors.primaryColorBlue,
                fontSize: 12,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget autoComplete(List<InvoiceModel> invoices) {
    InvoiceModel emptyInvoice = const InvoiceModel();
    // getIt.get<InvoiceCubit>().getInvoices();
    // invoices = getIt.get<InvoiceCubit>().invoices;
    List<InvoiceModel> kOptions = invoices;

    return Autocomplete<InvoiceModel>(
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            final InvoiceModel option = options.elementAt(index);
            return GestureDetector(
              onTap: () {
                onSelected(option);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.primaryColorBlue.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
                child: Text(
                  "Number: ${option.invNo!}    ID: ${option.invid!}    Name: ${option.custInvname!.isEmpty ? "N/A" : option.custInvname}",
                  style: TextStyle(fontSize: 11.sp, color: Colors.white),
                ),
              ),
            );
          },
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return CustomTextFormField(
          labelText: AppLocalizations.of(context)!.search,
          hintText: AppLocalizations.of(context)!.search_with_id_code_barcode,
          prefixIcon: Icons.receipt_long_rounded,
          prefixIconColor: const Color.fromARGB(255, 49, 101, 128),
          suffixIcon: Icons.search,
          suffixIconSize: 16.sp,
          suffixColor: Colors.blueGrey,
          prefixIconSize: 17.sp,
          controller: textEditingController,
          focusNode: focusNode,
          onSubmit: (_) => onFieldSubmitted(),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<InvoiceModel>.empty();
        }
        List<InvoiceModel> filteredOptions = kOptions
            .where(
              (invoice) =>
                  invoice.custInvname!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()) ||
                  invoice.invNo!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()) ||
                  invoice.invdate.toString().contains(textEditingValue.text) ||
                  invoice.invid.toString().contains(textEditingValue.text),
            )
            .toList();

        return filteredOptions
            .take(10); // Limit the options to the first 10 items
      },
      onSelected: (InvoiceModel selectedInvoice) {
        if (selectedInvoice != emptyInvoice) {
          GlobalMethods.buildFlutterToast(
            message: 'Invoice Selected Successfully',
            state: ToastStates.SUCCESS,
          );
          SharedPref.set(key: 'ReturnSelectedId', value: selectedInvoice.invid);
          setState(() {});
        } else {
          GlobalMethods.buildFlutterToast(
            message: 'No invoice found for the entered Number.',
            state: ToastStates.ERROR,
          );
        }
        debugPrint(
            "invoicceeeeshared pref ${SharedPref.get(key: 'ReturnSelectedId')}");
      },
      displayStringForOption: (option) => "${option.invid!}",
    );
  }

  void validateInvoice() {
    InvoiceModel emptyInvoice = const InvoiceModel();
    getIt.get<InvoiceCubit>().getInvoices();
    invoices = getIt.get<InvoiceCubit>().invoices;
    String searchText = searchController.text.trim();
    try {
      selectedInvoice = invoices.singleWhere(
        (invoice) =>
            invoice.custInvname!.toLowerCase().contains(searchText) ||
            invoice.invNo!.toLowerCase().contains(searchText) ||
            invoice.invdate!.toString().contains(searchText) ||
            invoice.invid!.toString().contains(searchText),
      );
    } catch (e) {
      selectedInvoice = emptyInvoice;
    }

    if (selectedInvoice != emptyInvoice) {
      GlobalMethods.buildFlutterToast(
        message: 'Invoice Selected Successfully',
        state: ToastStates.SUCCESS,
      );
      SharedPref.set(key: 'ReturnSelectedId', value: selectedInvoice!.invid);
      setState(() {});
    } else {
      GlobalMethods.buildFlutterToast(
        message: 'No invoice found for the entered Number.',
        state: ToastStates.ERROR,
      );
    }
    debugPrint("invoicceeeeshared pref ${SharedPref.get(key: 'ReturnSelectedId')}");
  }
}

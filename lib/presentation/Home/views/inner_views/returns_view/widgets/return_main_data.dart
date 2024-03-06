import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

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
            chooseWithInvoiseOrNot(),
            _isInvoiceSelected
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextBuilder(
                        AppLocalizations.of(context)!.invoice_number,
                        isHeader: true,
                        fontSize: 15,
                      ),
                      CustomTextFormField(
                        contentSize: 14,
                        labelText: "Search",
                        hintText: "Search with ID, Code, or Barcode NO",
                        suffixIcon: Icons.search,
                        suffixIconSize: 17.sp,
                        suffixColor: Colors.blueGrey,
                        controller: searchController,
                        suffixPressed: validateInvoice,
                      ),
                    ],
                  )
                : Container(),
            TextBuilder(
              AppLocalizations.of(context)!.return_id,
              isHeader: true,
              fontSize: 15,
            ),
            const CustomTextFormField(
              contentSize: 14,
              labelText: "AUTO",
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

  chooseWithInvoiseOrNot() {
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
                if (getIt.get<AddItemCubit>().addedItems.isNotEmpty) {
                  getIt.get<AddItemCubit>().addedItems.clear();
                  GlobalMethods.navigatePOP(context);
                }
                setState(() {
                  _isInvoiceSelected = true;
                  SharedPref.set(key: "withInvoiceSelected", value: true);
                  print("${SharedPref.get(key: "withInvoiceSelected")}");
                });
              },
              child: TextBuilder(
                'With Invoice',
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
                  print("${SharedPref.get(key: "withInvoiceSelected")}");
                });
              },
              child: TextBuilder(
                'Without Invoice',
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

  void validateInvoice() {
    InvoiceModel emptyInvoice = InvoiceModel();
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
    print("invoicceeeeshared pref ${SharedPref.get(key: 'ReturnSelectedId')}");
  }
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
import '../../../../../cubits/customer_cubit/customer_cubit.dart';
import 'pick_date_widget.dart';
import 'sellect_cash_or_postpon_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceMainDataSection extends StatelessWidget {
  InvoiceMainDataSection({
    super.key,
  });
  final invoiceIDController = TextEditingController();
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
            TextBuilder(
              AppLocalizations.of(context)!.invoice_id,
              isHeader: true,
              fontSize: 16,
            ),
            CustomTextFormField(
              labelText: AppLocalizations.of(context)!.auto,
              centerContent: true,
              isLabelBold: true,
              isClickable: false,
              controller: invoiceIDController,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.invoice_date,
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
              AppLocalizations.of(context)!.invoice_type,
              isHeader: true,
              fontSize: 16,
            ),
            const SellectCashOrCreditSection(),
          ],
        ),
      ),
    );
  }
}

class SearchOnCustomerSection extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Function()? suffixPressed;
  final Function()? prefixPressed;
  final bool isSecure;
  final bool isLabelBold;
  final bool isContentBold;
  final bool centerContent;
  final double contentSize;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool isClickable;
  final Color backgroundOfTextFeild;
  final Color notFocusedBorderColor;
  final Color focusedBorderColor;
  final int? maxLines;
  final FocusNode? focusNode;

  const SearchOnCustomerSection({
    super.key,
    this.centerContent = false,
    required this.labelText,
    this.prefixPressed,
    this.hintText,
    this.contentSize = 18,
    this.keyboardType,
    this.prefixIcon,
    this.prefixIconColor,
    this.validator,
    this.suffixIcon,
    this.suffixColor,
    this.suffixPressed,
    this.isSecure = false,
    this.isLabelBold = false,
    this.isContentBold = false,
    this.onSubmit,
    this.isClickable = true,
    this.maxLines = 1,
    this.focusNode,
    this.onChange,
    this.onTap,
    this.backgroundOfTextFeild = const Color.fromRGBO(227, 227, 227, 1),
    this.notFocusedBorderColor = Colors.transparent,
    this.focusedBorderColor = Colors.transparent,
  });

  @override
  State<SearchOnCustomerSection> createState() =>
      SearchOnCustomerSectionState();
}

class SearchOnCustomerSectionState extends State<SearchOnCustomerSection> {
  TextEditingController myController = TextEditingController();
  var customerKey = GlobalKey<DropdownSearchState>();
  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<CustomerModel> customers = CustomerCubit.get(context).customers;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: DropdownSearch<CustomerModel>(
            key: customerKey,
            items: customers,
            itemAsString: (CustomerModel cust) => cust.custname!,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
            ),
            dropdownButtonProps: const DropdownButtonProps(
              color: AppColors.primaryColorBlue,
            ),
            validator: (value) {
              if (value == null) {
                return "please select a customer";
              }
              return null;
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              textAlign: TextAlign.center,
              baseStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlignVertical: TextAlignVertical.center,
              dropdownSearchDecoration: InputDecoration(
                  label: TextBuilder(widget.labelText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
            ),
            onChanged: (CustomerModel? data) {
              debugPrint("${data!.custid}");
              debugPrint(data.custname);
              debugPrint(data.custename);
              setState(() {
                SharedPref.set(key: "custID", value: data.custid);
                SharedPref.set(
                    key: "custName",
                    value: data.custname ?? data.custename ?? 'cash');
              });
              debugPrint(
                SharedPref.get(key: "custID"),
              );
            },
          ),
        );
      },
    );
  }
}

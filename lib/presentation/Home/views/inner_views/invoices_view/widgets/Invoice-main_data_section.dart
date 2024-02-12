import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/presentation/Home/view_models/customer_cubit/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../../../../core/widgets/text_builder.dart';
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
            boxShadow: [
              const BoxShadow(
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
              labelText: "AUTO ",
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
            Row(
              children: [
                const Flexible(child: DatePickerWidget()),
                const GapW(w: 1),
                Flexible(child: HoursAndMinutes()),
              ],
            ),
            SearchSection(
              labelText: AppLocalizations.of(context)!.customer,
            ),
            const GapH(h: 1),
            TextBuilder(
              AppLocalizations.of(context)!.invoice_type,
              isHeader: true,
              fontSize: 16,
            ),
            const SellectCashOrPostponeSection(),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
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

  SearchSection({
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
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  TextEditingController myController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCustomerCubit, GetCustomerState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<CustomerModel> customers = GetCustomerCubit.get(context).customers;
        List<String> customersNames = ["Cash"];
        for (var customer in customers) {
          customersNames.add(customer.custname ?? customer.custename ?? "");
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: TextFieldSearch(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelStyle: TextStyle(
                  color: widget.focusedBorderColor,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: widget.backgroundOfTextFeild,
                border: const OutlineInputBorder(
                    // borderSide: BorderSide(width: 3, color: Colors.yellowAccent),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: widget.notFocusedBorderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide:
                      BorderSide(color: widget.focusedBorderColor, width: 2),
                ),
                label: TextBuilder(
                  widget.labelText,
                  isHeader: widget.isLabelBold,
                  // textAlign: TextAlign.center,
                ),
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : IconButton(
                        onPressed: widget.prefixPressed,
                        icon: Icon(
                          widget.prefixIcon,
                          color: widget.prefixIconColor,
                        ),
                      ),
                suffixIcon: widget.suffixIcon == null
                    ? null
                    : IconButton(
                        onPressed: widget.suffixPressed,
                        icon: Icon(
                          widget.suffixIcon,
                          color: widget.suffixColor,
                        ),
                      ),
              ),
              initialList: customersNames.length == 0
                  ? ["No Customers"]
                  : customersNames,
              label: widget.labelText,
              textStyle: TextStyle(
                fontFamily: "Cairo",
                fontSize: widget.contentSize.sp,
                fontWeight:
                    widget.isContentBold ? FontWeight.bold : FontWeight.normal,
              ),
              controller: myController),
        );
      },
    );
  }
}

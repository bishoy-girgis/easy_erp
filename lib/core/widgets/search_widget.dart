// import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';

// class SearchWidget extends StatefulWidget {
//   const SearchWidget({super.key});

//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }
//   TextEditingController searchController = TextEditingController();
//   List<InvoiceModel> searchForInvoices = [];
//     List<InvoiceModel> invoices = [];
// class _SearchWidgetState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//               labelText: AppLocalizations.of(context)!.search,
//               // hintText: "Search with Customer name",
//               suffixIcon: Icons.search,
//               backgroundOfTextFeild: Colors.white,
//               onChange: (v) {
//                 searchController.text = v;
//                 searchForInvoices = invoices
//                     .where((invoice) =>
//                         invoice.custInvname!.toLowerCase().startsWith(v) ||
//                         invoice.invNo!.toLowerCase().startsWith(v) ||
//                         invoice.invdate!.toString().startsWith(v))
//                     .toList();
//                 setState(() {});
//               },
//             );
//   }
// }

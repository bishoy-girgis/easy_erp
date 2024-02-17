// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:textfield_search/textfield_search.dart';

// import '../../../../../../core/widgets/text_builder.dart';
// import '../../../../../../data/models/customer_model/customer_model.dart';
// import '../../../../view_models/customer_cubit/customer_cubit.dart';

// class SearchOnCustomerSection extends StatefulWidget {
//   final String labelText;
//   final String? hintText;
//   final TextInputType? keyboardType;
//   final IconData? prefixIcon;
//   final Color? prefixIconColor;
//   final String? Function(String?)? validator;
//   final IconData? suffixIcon;
//   final Color? suffixColor;
//   final Function()? suffixPressed;
//   final Function()? prefixPressed;
//   final bool isSecure;
//   final bool isLabelBold;
//   final bool isContentBold;
//   final bool centerContent;
//   final double contentSize;
//   final Function(String)? onSubmit;
//   final Function(String)? onChange;
//   final Function()? onTap;
//   final bool isClickable;
//   final Color backgroundOfTextFeild;
//   final Color notFocusedBorderColor;
//   final Color focusedBorderColor;
//   final int? maxLines;
//   final FocusNode? focusNode;

//   SearchOnCustomerSection({
//     super.key,
//     this.centerContent = false,
//     required this.labelText,
//     this.prefixPressed,
//     this.hintText,
//     this.contentSize = 18,
//     this.keyboardType,
//     this.prefixIcon,
//     this.prefixIconColor,
//     this.validator,
//     this.suffixIcon,
//     this.suffixColor,
//     this.suffixPressed,
//     this.isSecure = false,
//     this.isLabelBold = false,
//     this.isContentBold = false,
//     this.onSubmit,
//     this.isClickable = true,
//     this.maxLines = 1,
//     this.focusNode,
//     this.onChange,
//     this.onTap,
//     this.backgroundOfTextFeild = const Color.fromRGBO(227, 227, 227, 1),
//     this.notFocusedBorderColor = Colors.transparent,
//     this.focusedBorderColor = Colors.transparent,
//   });

//   @override
//   State<SearchOnCustomerSection> createState() =>
//       _SearchOnCustomerSectionState();
// }

// class _SearchOnCustomerSectionState extends State<SearchOnCustomerSection> {
//   TextEditingController myController = TextEditingController();

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetCustomerCubit, GetCustomerState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         List<CustomerModel> customers = GetCustomerCubit.get(context).customers;
//         List<String> customersNames = ["Cash"];
//         for (var customer in customers) {
//           customersNames.add(customer.custname ?? customer.custename ?? "");
//         }
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           child: TextFieldSearch(
//             decoration: InputDecoration(
//               alignLabelWithHint: true,
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
//               floatingLabelBehavior: FloatingLabelBehavior.never,
//               floatingLabelStyle: TextStyle(
//                 color: widget.focusedBorderColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               filled: true,
//               fillColor: widget.backgroundOfTextFeild,
//               border: const OutlineInputBorder(
//                   // borderSide: BorderSide(width: 3, color: Colors.yellowAccent),
//                   borderRadius: BorderRadius.all(Radius.circular(16))),
//               enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(width: 2, color: widget.notFocusedBorderColor),
//                   borderRadius: const BorderRadius.all(Radius.circular(16))),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//                 borderSide:
//                     BorderSide(color: widget.focusedBorderColor, width: 2),
//               ),
//               label: TextBuilder(
//                 widget.labelText,
//                 isHeader: widget.isLabelBold,
//                 // textAlign: TextAlign.center,
//               ),
//               hintText: widget.hintText,
//               prefixIcon: widget.prefixIcon == null
//                   ? null
//                   : IconButton(
//                       onPressed: widget.prefixPressed,
//                       icon: Icon(
//                         widget.prefixIcon,
//                         color: widget.prefixIconColor,
//                       ),
//                     ),
//               suffixIcon: widget.suffixIcon == null
//                   ? null
//                   : IconButton(
//                       onPressed: widget.suffixPressed,
//                       icon: Icon(
//                         widget.suffixIcon,
//                         color: widget.suffixColor,
//                       ),
//                     ),
//             ),
//             initialList:
//                 customersNames.length == 0 ? ["No Customers"] : customersNames,
//             label: widget.labelText,
//             textStyle: TextStyle(
//               fontFamily: "Cairo",
//               fontSize: widget.contentSize.sp,
//               fontWeight:
//                   widget.isContentBold ? FontWeight.bold : FontWeight.normal,
//             ),
//             controller: myController,
//             getSelectedValue: (v) {
//               print(v);
//             },
//           ),
//         );
//       },
//     );
//   }
// }

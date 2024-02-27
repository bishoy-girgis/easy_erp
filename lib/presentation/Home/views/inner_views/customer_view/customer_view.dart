import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/widgets/customer_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_colors.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../cubits/customer_cubit/customer_cubit.dart';
import '../items_view/widgets/item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerView extends StatefulWidget {
  CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  // List<CustomerModel> customers = [];
  List<CustomerModel> searchForCustomers = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomerCubit.get(context).getCustomerGroups();
          GlobalMethods.goRouterNavigateTO(
              context: context, router: AppRouters.kCreateNewCustomer);
        },
        child: Icon(
          Icons.person_add_alt_rounded,
          size: 25.sp,
          color: AppColors.primaryColorBlue,
        ),
      ),
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.customers,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: AppLocalizations.of(context)!.search,
              hintText: "Search with Customer name",
              suffixIcon: Icons.search,
              controller: searchController,
              backgroundOfTextFeild: Colors.white,
              onChange: (v) {
                searchController.text = v;
                searchForCustomers = CustomerCubit.get(context)
                    .customers
                    .where((customer) =>
                        customer.custname!.toLowerCase().startsWith(v) ||
                        customer.custename!.toLowerCase().startsWith(v) ||
                        customer.custcode!.toString().startsWith(v))
                    .toList();
                setState(() {});
              },
            ),
            const GapH(h: 1),
            BlocConsumer<CustomerCubit, CustomerState>(
              listener: (context, state) {
                if (state is GetCustomerSuccessState) {}
              },
              builder: (context, state) {
                // customers = CustomerCubit.get(context).customers;
                if (CustomerCubit.get(context).customers.isNotEmpty) {
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
                        itemCount: searchForCustomers.isNotEmpty
                            ? searchForCustomers.length
                            : CustomerCubit.get(context).customers.length,
                        itemBuilder: (context, index) {
                          return CustomerWidget(
                            customerModel: searchForCustomers.isNotEmpty
                                ? searchForCustomers[index]
                                : CustomerCubit.get(context).customers[index],
                          );
                        }),
                  ));
                } else {
                  return const Center(
                    child: Text(
                      "No Customers Found",
                      style: TextStyle(
                        color: AppColors.primaryColorBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                // if (state is GetCustomerSuccessState) {
                //   return Expanded(
                //       child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       color: AppColors.whiteColor,
                //     ),
                //     child: ListView.builder(
                //         padding: const EdgeInsets.symmetric(
                //           vertical: 10,
                //         ),
                //         itemCount: state.customers.length,
                //         itemBuilder: (context, index) {
                //           return CustomerWidget(
                //             customerModel: state.customers[index],
                //           );
                //         }),
                //   ));
                // } else if (state is GetCustomerFailureState) {
                //   debugPrint(state.error);
                //   return const Center(
                //     child: TextBuilder(
                //         "Sorry there is error , we will work on it "),
                //   );
                // } else if (state is GetCustomerLoadingState) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                //   return const Center(
                //     child: TextBuilder("SMTH WEN WRONG"),
                //   );
                // }
              },
            )
          ],
        ),
      ),
    );
  }
}

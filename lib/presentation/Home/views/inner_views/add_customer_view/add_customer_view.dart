import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/cubits/customer_cubit/customer_cubit.dart';
import 'package:easy_erp/data/models/group_model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data/models/payment_type_model/pay_ment_type_model.dart';
import '../../../../../data/services/local/shared_pref.dart';
import 'widgets/select_group_section.dart';

class AddCustomerView extends StatelessWidget {
  AddCustomerView({super.key});
  final TextEditingController _custNameArController = TextEditingController();
  final TextEditingController _custNameEnController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _managerNameArController =
      TextEditingController();
  final TextEditingController _managerNameEnController =
      TextEditingController();
  final TextEditingController _addressEnController = TextEditingController();
  final TextEditingController _addressArController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          "Add Customer",
          color: AppColors.whiteColor,
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is AddCustomerSuccess) {
            GlobalMethods.buildFlutterToast(
              message: state.addCustomerResponseModel.massage!,
              state: ToastStates.SUCCESS,
            );
            CustomerCubit.get(context).getCustomers();
            GlobalMethods.goRouterNavigateTOAndReplacement(
              context: context,
              router: AppRouters.kCustomers,
            );
          } else if (state is AddCustomerFailure) {
            GlobalMethods.buildFlutterToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          } else {
            GlobalMethods.buildFlutterToast(
              message: "Loading ... ",
              state: ToastStates.WARNING,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                GapH(h: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'Customer name AR',
                        controller: _custNameArController,
                        onChange: (value) {
                          _custNameArController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Customer name EN',
                        controller: _custNameEnController,
                        onChange: (value) {
                          _custNameEnController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Fax',
                        controller: _faxController,
                        onChange: (value) {
                          _faxController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Mobile number',
                        controller: _mobileNumberController,
                        onChange: (value) {
                          _mobileNumberController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Address ar',
                        controller: _addressArController,
                        onChange: (value) {
                          _addressArController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Address en',
                        controller: _addressEnController,
                        onChange: (value) {
                          _addressEnController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Managet name ar',
                        controller: _managerNameArController,
                        onChange: (value) {
                          _managerNameArController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        labelText: 'Managet name en',
                        controller: _managerNameEnController,
                        onChange: (value) {
                          _managerNameEnController.text = value;
                        },
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'Please enter customer name';
                          }
                          return null;
                        },
                      ),
                      GapH(h: 2),
                      ChooseGroup()
                    ],
                  ),
                ),
                GapH(h: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomElevatedButton(
                    width: double.infinity,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var customer = context
                            .read<CustomerCubit>()
                            .addCustomer(
                              custNameAr: _custNameArController.text,
                              custNameEn: _custNameEnController.text,
                              fax: _faxController.text,
                              mobileNumber: _mobileNumberController.text,
                              addressAr: _addressArController.text,
                              addressEn: _addressEnController.text,
                              mangNameAr: _managerNameArController.text,
                              mangNameEn: _managerNameEnController.text,
                              groupID: SharedPref.get(key: 'custCategoryId'),
                            );
                        FocusScope.of(context).unfocus();
                      }
                    },
                    backgroundColor: AppColors.whiteColor,
                    title: TextBuilder(
                      "Add Customer",
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

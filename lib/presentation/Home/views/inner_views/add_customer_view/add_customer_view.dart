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
          AppLocalizations.of(context)!.add_customer,
          color: AppColors.whiteColor,
        ),
        leading: IconButton(
            onPressed: () {
              CustomerCubit.get(context).getCustomers();
              GlobalMethods.navigatePOP(context);
            },
            icon: Icon(Icons.arrow_back)),
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
            SharedPref.remove(key: 'custCategoryId');
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
            child: Card(
              child: Column(
                children: [
                  // GapH(h: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.customer_name_ar,
                          controller: _custNameArController,
                          onChange: (value) {
                            _custNameArController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_customer_name;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.customer_name_en,
                          controller: _custNameEnController,
                          onChange: (value) {
                            _custNameEnController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_customer_name;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.fax,
                          controller: _faxController,
                          onChange: (value) {
                            _faxController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_fax;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.mobile_number,
                          controller: _mobileNumberController,
                          onChange: (value) {
                            _mobileNumberController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_mobile_number;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.address_ar,
                          controller: _addressArController,
                          onChange: (value) {
                            _addressArController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_address;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.address_en,
                          controller: _addressEnController,
                          onChange: (value) {
                            _addressEnController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_address;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.manager_name_ar,
                          controller: _managerNameArController,
                          onChange: (value) {
                            _managerNameArController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_manager_name;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.manager_name_en,
                          controller: _managerNameEnController,
                          onChange: (value) {
                            _managerNameEnController.text = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_manager_name;
                            }
                            return null;
                          },
                        ),
                        const GapH(h: 1),
                        const ChooseGroup()
                      ],
                    ),
                  ),
                  const GapH(h: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomElevatedButton(
                      width: double.infinity,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var customer = await context
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
                      // backgroundColor: AppColors.whiteColor,
                      title: TextBuilder(
                        AppLocalizations.of(context)!.add_customer,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const GapH(h: 5)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

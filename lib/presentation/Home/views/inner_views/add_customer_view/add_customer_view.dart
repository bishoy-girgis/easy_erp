import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/gap.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../data/services/local/shared_pref.dart';
import '../../../../cubits/customer_cubit/customer_cubit.dart';
import 'widgets/select_group_section.dart';

class AddCustomerView extends StatefulWidget {
  AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends State<AddCustomerView> {
  TextEditingController custNameArController = TextEditingController();

  // final TextEditingController? _custNameEnController = TextEditingController();
  String? custNameEnController;

  String? faxController;

  String? mobileNumberController;

  String? managerNameArController;

  String? managerNameEnController;

  String? addressEnController;

  String? addressArController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBuilder(
          AppLocalizations.of(context)!.add_customer,
          color: AppColors.whiteColor,
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       CustomerCubit.get(context).getCustomers();
        //       GlobalMethods.navigatePOP(context);
        //     },
        //     icon: Icon(Icons.arrow_back)),
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
            GlobalMethods.goRouterNavigateTOAndReplacement(
              context: context,
              router: AppRouters.kCustomers,
            );
            debugPrint(
                "${state.addCustomerResponseModel.customercode} :::");
            SharedPref.remove(key: 'custCategoryId');
          } else if (state is AddCustomerFailure) {
            GlobalMethods.buildFlutterToast(
              message: state.error,
              state: ToastStates.ERROR,
            );
          } else {
            GlobalMethods.buildFlutterToast(
              message: AppLocalizations.of(context)!.loading,
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
                          onChange: (value) {
                            custNameArController.text = value;
                            debugPrint(custNameArController.text);
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
                          //controller: _custNameEnController,
                          onChange: (value) {
                            custNameEnController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_customer_name;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.fax,
                          //controller: _faxController,
                          onChange: (value) {
                            faxController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_fax;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.mobile_number,
                          //controller: _mobileNumberController,
                          onChange: (value) {
                            mobileNumberController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_mobile_number;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.address_ar,
                          //controller: _addressArController,
                          onChange: (value) {
                            addressArController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_address;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText: AppLocalizations.of(context)!.address_en,
                          //controller: _addressEnController,
                          onChange: (value) {
                            addressEnController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_address;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.manager_name_ar,
                          //controller: _managerNameArController,
                          onChange: (value) {
                            managerNameArController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_manager_name;
                          //   }
                          //   return null;
                          // },
                        ),
                        CustomTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.manager_name_en,
                          //controller: _managerNameEnController,
                          onChange: (value) {
                            managerNameEnController = value;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return AppLocalizations.of(context)!
                          //         .please_enter_manager_name;
                          //   }
                          //   return null;
                          // },
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
                          if (SharedPref.get(key: 'custCategoryId') != null) {
                            var customer =
                                await context.read<CustomerCubit>().addCustomer(
                                      custNameAr: custNameArController.text,
                                      custNameEn: custNameEnController,
                                      fax: faxController,
                                      mobileNumber: mobileNumberController,
                                      addressAr: addressArController,
                                      addressEn: addressEnController,
                                      mangNameAr: managerNameArController,
                                      mangNameEn: managerNameEnController,
                                      groupID:
                                          SharedPref.get(key: 'custCategoryId'),
                                    );
                            FocusScope.of(context).unfocus();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("please choose group"),
                              ),
                            );
                          }
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

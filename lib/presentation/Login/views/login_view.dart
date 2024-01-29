import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/utils.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/providers/localization/localization_provider.dart';
import 'package:easy_erp/data/providers/login/login_provider.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Login/views/widgets/change_language_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/app_colors.dart';
import '../../../core/helper/app_images.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    Intl.getCurrentLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    var size = Utils(context: context).screenSize;
    return Scaffold(
      backgroundColor: AppColors.primaryColorBlue,
      body: SafeArea(
          child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: AppColors.blackColor,
                offset: Offset(3, 5),
              ),
            ],
            color: AppColors.whiteColor,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: size.height * 0.25,
                    width: size.height * 0.25,
                  ),
                  CustomTextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .login_username_required;
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.userName,
                    hintText: AppLocalizations.of(context)!.userNameHint,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .login_password_required;
                      }
                      return null;
                    },
                    isSecure: true,
                    suffixIcon: loginProvider.isVisability
                        ? Icons.visibility
                        : Icons.visibility_off,
                    suffixPressed: () {
                      loginProvider.changeVisability();
                    },
                    labelText: AppLocalizations.of(context)!.password,
                    hintText: AppLocalizations.of(context)!.passwordHint,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   var userName = userNameController.text;
                      //   var password = passwordController.text;
                      //   SharedPref.set(key: 'userName', value: userName);
                      //   SharedPref.set(key: 'password', value: password);
                      //   GlobalMethods.goRouterNavigateTO(
                      //       context: context, router: AppRouters.kHome);
                      // }
                      GlobalMethods.goRouterNavigateTO(
                          context: context, router: AppRouters.kHome);
                    },
                    width: double.infinity,
                    title: AppLocalizations.of(context)!.login,
                  ),
                  ChangeLanguagesSection()
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

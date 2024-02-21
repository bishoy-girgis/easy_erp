import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/app_routing.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/helper/utils.dart';
import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/presentation/Login/view_models/cubits/login_cubit/login_cubit.dart';
import 'package:easy_erp/presentation/Login/views/widgets/change_language_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/app_colors.dart';
import '../../../core/helper/app_images.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../data/models/user/user_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

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
    var size = Utils(context: context).screenSize;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          debugPrint("🎄🎄" + state.userModel.userName!);
          debugPrint("🎄🎄" + state.userModel.accessToken!);

          SharedPref.set(key: 'userName', value: state.userModel.userName);
          SharedPref.set(
              key: 'accessToken', value: state.userModel.accessToken);
          SharedPref.set(key: 'whId', value: state.userModel.whId);
          SharedPref.set(key: 'vat', value: state.userModel.vat);
          SharedPref.set(key: 'ccid', value: state.userModel.ccId);
          SharedPref.set(key: 'branchID', value: state.userModel.branchId);
          Hive.box<UserModel>("userBox").put("userName", state.userModel);
          GlobalMethods.goRouterNavigateTOAndReplacement(
              context: context, router: AppRouters.kHome);
          GlobalMethods.buildFlutterToast(
            message: "Welcome to Easy ERP App",
            state: ToastStates.SUCCESS,
          );
        } else if (state is LoginFailureState) {
          debugPrint("🎐🎐" + state.error);

          GlobalMethods.buildFlutterToast(
              message: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                        onChange: (value) {
                          passwordController.text = value;
                        },
                        onSubmit: (value) {
                          passwordController.text = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .login_password_required;
                          }
                          return null;
                        },
                        isSecure: getIt.get<LoginCubit>().isPasswordVisible,
                        suffixIcon: getIt.get<LoginCubit>().isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        suffixPressed: () {
                          getIt.get<LoginCubit>().changeVisability();
                        },
                        labelText: AppLocalizations.of(context)!.password,
                        hintText: AppLocalizations.of(context)!.passwordHint,
                      ),
                      state is LoginLoadingState
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  /// Perform login
                                  await context.read<LoginCubit>().userLogin(
                                        userName: userNameController.text,
                                        password: passwordController.text,
                                      );
                                }
                                FocusScope.of(context).unfocus();
                              },
                              width: double.infinity,
                              title: TextBuilder(
                                AppLocalizations.of(context)!.login,
                                color: AppColors.whiteColor,
                              ),
                            ),
                      const ChangeLanguagesSection(),
                      TextButton.icon(
                        onPressed: () {
                          GlobalMethods.goRouterNavigateTOAndReplacement(
                            context: context,
                            router: AppRouters.kSettings,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        label: TextBuilder(
                          AppLocalizations.of(context)!.go_to_settings,
                          color: AppColors.primaryColorBlue,
                          isHeader: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}

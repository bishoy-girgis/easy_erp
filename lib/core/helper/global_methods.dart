import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/widgets/text_builder.dart';
import 'package:easy_erp/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalMethods {
  static Future<void> showAlertAdressDialog(BuildContext context,
      {required String title,
      TextEditingController? controller,
      Function()? onPressedButton1,
      Function()? onPressedButton2,
      String? titleButton1,
      String? titleButton2,
      Widget? content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: TextBuilder(title),
          content: content,
          actions: [
            titleButton1 != null
                ? Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onPressedButton1,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColorBlue,
                      ),
                      child: TextBuilder(
                        titleButton1,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                : Container(),
            titleButton2 != null
                ? Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onPressedButton2,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: TextBuilder(
                        titleButton2,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  static Future<bool?> buildFlutterToast({
    required String message,
    required ToastStates state,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Color _chooseToastColor(ToastStates state) {
    Color color;
    switch (state) {
      case ToastStates.SUCCESS:
        color = AppColors.secondColorOrange;
        break;

      case ToastStates.ERROR:
        color = Colors.red;
        break;
      case ToastStates.WARNING:
        color = AppColors.blackColor;
        break;
    }
    return color;
  }

  static Future goRouterNavigateTO(
      {required BuildContext context, required String router}) {
    return navigatorKey.currentState!.pushNamed(router);
  }

  static Future goRouterNavigateTOAndReplacement(
      {required BuildContext context, required String router}) {
    return navigatorKey.currentState!.pushReplacementNamed(router);
  }

  // static Future goRouterNavigateTOWithExtraObject(
  //     {required BuildContext context,
  //     required String router,
  //     Object? extraObject}) {
  //   return GoRouter.of(context).pushNamed(
  //     router,
  //     extra: extraObject,
  //   );
  // }

  static goRouterPOP(
    BuildContext context,
  ) {
    return navigatorKey.currentState!.pop();
  }

  // static goRouterPOPWithData(BuildContext context, var data) {
  //   return GoRouter.of(context).pop(data);
  // }

  // static Future goRouterNavigateTOWithQueryParameters(
  //     {required BuildContext context,
  //     required String router,
  //     required Map<String, dynamic> queryParameters}) {
  //   return GoRouter.of(context).pushNamed(
  //     router,
  //     queryParameters: queryParameters,
  //   );
  // }

  static navigateTo(context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => screen,
      ),
    );
  }

  static navigatePOP(context) {
    Navigator.of(context).pop();
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }

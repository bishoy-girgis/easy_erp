import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class GlobalMethods {
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
        color = Colors.green;
        break;

      case ToastStates.ERROR:
        color = Colors.red;
        break;
      case ToastStates.WARNING:
        color = const Color.fromARGB(255, 165, 99, 0);
        break;
    }
    return color;
  }

  static Future goRouterNavigateTO(
      {required BuildContext context, required String router}) {
    return GoRouter.of(context).push(router);
  }

  static Future goRouterNavigateTOAndReplacement(
      {required BuildContext context, required String router}) {
    return GoRouter.of(context).pushReplacement(router);
  }

  static Future goRouterNavigateTOWithExtraObject(
      {required BuildContext context,
      required String router,
      Object? extraObject}) {
    return GoRouter.of(context).pushNamed(
      router,
      extra: extraObject,
    );
  }

  static goRouterPOP(
    BuildContext context,
  ) {
    return GoRouter.of(context).pop();
  }

  static Future goRouterNavigateTOWithQueryParameters(
      {required BuildContext context,
      required String router,
      required Map<String, dynamic> queryParameters}) {
    return GoRouter.of(context).pushNamed(
      router,
      queryParameters: queryParameters,
    );
  }

  static navigateTo(context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => screen,
      ),
    );
  }
}

enum ToastStates { SUCCESS, ERROR, WARNING }

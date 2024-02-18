import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/global_methods.dart';
import 'package:flutter/foundation.dart';

abstract class Failures {
  final String errorMessage;
  const Failures(
    this.errorMessage,
  );
}

class ServerError extends Failures {
  ServerError(super.errorMessage);
  factory ServerError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerError("Connection Timeout with Api Server");
      case DioExceptionType.sendTimeout:
        return ServerError("Send Timeout with Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerError("Receive Timeout with Api Server");
      case DioExceptionType.badCertificate:
        return ServerError("Bad Certificate with Api Server");
      case DioExceptionType.badResponse:
        debugPrint("😡😡😡BAD Response😡😡😡");
        debugPrint("😡😡😡😡😡😡" + DioExceptionType.badResponse.name);
        // GlobalMethods.buildFlutterToast(
        //     message: "BAD Response", state: ToastStates.ERROR);
        return ServerError.fromBadResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerError("CANCEL with Api Server");
      case DioExceptionType.connectionError:
        return ServerError(
            DioExceptionType.connectionError.runtimeType.toString());

      case DioExceptionType.unknown:
        if (dioError.message!.contains('Socket')) {
          return ServerError("No Internet Connection 2 ");
        } else {
          return ServerError("Try AGAIN");
        }
      default:
        return ServerError("DEFAULT ERROR TRY AGIAN LATER ");
    }
  }
  factory ServerError.fromBadResponse(statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 403) {
      return ServerError(response['massage']);
    } else if (statusCode == 401) {
      // return ServerError("ERROR RRRR 401");
      return ServerError(response['Message'].toString());
    } else if (statusCode == 404) {
      return ServerError('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerError('Internal Server error, Please try later');
    } else {
      return ServerError('Opps There was an Error, Please try again');
    }
  }
}

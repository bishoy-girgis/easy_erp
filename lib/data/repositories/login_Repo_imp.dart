import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api_services/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:easy_erp/data/repositories/login_Repo.dart';

class LoginRepoImplementation extends LoginRepo {
  ApiService apiService;
  LoginRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, UserModel>> userLogin({
    required String userName,
    required String password,
  }) async {
    try {
      print("DATA IN LOGIN REPO IMP ✨✨");
      var data = await apiService.post(
        endPoint: AppConstants.LOGIN_AND_TOKEN,
        // headers: {
        //   'Content-Type': 'application/x-www-form-urlencoded',
        // },
        body: {
          'username': userName,
          'password': password,
          'grant_type': "password",
        },
      );

      // print("AFTER DATA IN LOGIN REPO IMP  ✨✨" + data['UserName']);
      UserModel userModel = UserModel.fromJson(data);
      print('😒😒😒 Token Type : ' + userModel.tokenType.toString());
      print('😒😒😒 Token: ' + userModel.accessToken.toString());
      return right(userModel);
    } catch (e) {
      print("ERROR IN CACH ERROR LOGIN REPO IMP😡😡");
      print('😡😡' + e.toString());
      if (e is DioException) {
        return left(ServerError.fromDioError(e));
      } else {
        return left(
          ServerError(
            e.toString(),
          ),
        );
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/api/api_service.dart';
import 'package:easy_erp/core/errors/failures.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:easy_erp/data/repositories/login_repository/login_Repo.dart';
import 'package:flutter/cupertino.dart';

class LoginRepoImplementation extends LoginRepo {
  ApiService apiService;
  LoginRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, UserModel>> userLogin({
    required String userName,
    required String password,
  }) async {
    try {
      debugPrint("DATA IN LOGIN REPO IMP ✨✨");
      var data = await apiService.post(
        endPoint: AppConstants.LOGIN_AND_TOKEN,
        body: {
          'username': userName,
          'password': password,
          'grant_type': "password",
        },
      );

      UserModel userModel = UserModel.fromJson(data);
      return right(userModel);
    } catch (e) {
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

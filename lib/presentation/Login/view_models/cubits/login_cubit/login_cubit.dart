import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../core/helper/app_constants.dart';
import '../../../../../data/repositories/login_repository/login_Repo.dart';
import '../../../../../data/services/local/shared_pref.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  final LoginRepo loginRepo;
  late UserModel userModel;
  userLogin({required String userName, required String password}) async {
    emit(LoginLoadingState());
    var result =
        await loginRepo.userLogin(userName: userName, password: password);
    result.fold((error) {
      emit(LoginFailureState(error: error.errorMessage));
    }, (r) async {
      userModel = r;
      SharedPref.set(key: 'accessToken', value: userModel.accessToken!);
      debugPrint("🎄🎄***" + userModel.userName!);
      debugPrint("🎄🎄" + userModel.accessToken!);
      SharedPref.set(key: 'VATType', value: userModel.vatType);
      SharedPref.set(key: 'userName', value: userModel.userName!);
      SharedPref.set(key: 'whId', value: userModel.whId);
      SharedPref.set(key: 'vat', value: userModel.vat);
      SharedPref.set(key: 'ccid', value: userModel.ccId);
      SharedPref.set(key: 'branchID', value: userModel.branchId);
      AppConstants.updateValues();
      print("{{{{{{{{{{{{{{{{{{{{{ ${userModel.accessToken} }}}}}}}}}}}}}}}}}}}}}");
      print("-NAMMMEEE--------------------${userModel.userName!}--------------------");
      print("-NAMMMEEE22222--------------------${AppConstants.userName}--------------------");
      print("-TOKKEENN--------------------${AppConstants.accessToken}--------------------");

      emit(LoginSuccessState(userModel: r));

      return userModel;
    });
  }

  bool isPasswordVisible = true;
  void changeVisability() {
    emit(LoginInitial());
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisability());
  }
}

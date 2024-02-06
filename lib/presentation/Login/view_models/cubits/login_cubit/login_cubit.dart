import 'dart:developer';

import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repositories/login_Repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  final LoginRepo loginRepo;
  late UserModel userModel;
  userLogin({required String userName, required String password}) async {
    emit(LoginLoadingState());
    print("🐸🐸🐸🐸🐸🐸🐸");
    var result =
        await loginRepo.userLogin(userName: userName, password: password);
    result.fold((error) {
      print("😡😡😡");
      emit(LoginFailureState(error: error.errorMessage));
    }, (userModel) {
      // r foe list of user model
      print("❤️❤️");
      userModel = userModel;
      emit(LoginSuccessState(userModel: userModel));
    });
  }

  bool isPasswordVisible = true;
  void changeVisability() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisability());
  }
}

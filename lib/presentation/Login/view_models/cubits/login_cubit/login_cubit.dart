import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../data/repositories/login_repository/login_Repo.dart';

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

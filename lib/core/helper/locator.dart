import 'package:dio/dio.dart';
import 'package:easy_erp/data/repositories/login_repo_imp.dart';
import 'package:get_it/get_it.dart';

import '../api_services/api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocatorByGetIt() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<LoginRepoImplementation>(
    LoginRepoImplementation(getIt.get<ApiService>()),
  );
}

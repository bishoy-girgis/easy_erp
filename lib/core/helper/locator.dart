import 'package:dio/dio.dart';
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
    LoginRepoImplementation(
      ApiService(
        Dio(),
      ),
    ),
  );
}

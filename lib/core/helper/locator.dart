import 'package:dio/dio.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo_implementation.dart';
import 'package:easy_erp/data/repositories/login_repository/login_repo_imp.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/item_repository/item_repo_implementation.dart';
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
  getIt.registerSingleton<CustomerRepoImplementation>(
    CustomerRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ItemRepoImplementation>(
    ItemRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<AddItemCubit>(
    AddItemCubit(),
  );
}

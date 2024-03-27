import 'package:dio/dio.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo_implementation.dart';
import 'package:easy_erp/data/repositories/login_repository/login_repo_imp.dart';
import 'package:easy_erp/data/repositories/paid_repository/paid_repo_imp.dart';
import 'package:easy_erp/data/repositories/payer_type_repository/payer_type_repo_imp.dart';
import 'package:easy_erp/data/repositories/payment_type_repository/payment_type_repo_implementation.dart';
import 'package:easy_erp/data/repositories/reciept_repository/reciept_repo_imp.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo_imp.dart';
import 'package:easy_erp/presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/invoice_repository/invoice_repo_imp.dart';
import '../../data/repositories/item_repository/item_repo_implementation.dart';
import '../../presentation/cubits/addItem_cubit/add_item_cubit.dart';
import '../api/api_service.dart';

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
  getIt.registerSingleton<PaymentTypeRepoImp>(
    PaymentTypeRepoImp(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<PayerTypeRepoImp>(
    PayerTypeRepoImp(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<PayerTypeCubit>(
    PayerTypeCubit(getIt.get<PayerTypeRepoImp>()),
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

  getIt.registerSingleton<InvoiceRepoImplementation>(
    InvoiceRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<InvoiceCubit>(
    InvoiceCubit(invoiceRepo: getIt.get<InvoiceRepoImplementation>()),
  );
  getIt.registerSingleton<ReturnRepoImplementation>(
    ReturnRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<RecieptRepoImplementation>(
    RecieptRepoImplementation(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<PaidRepoImplementation>(
    PaidRepoImplementation(getIt.get<ApiService>()),
  );
}

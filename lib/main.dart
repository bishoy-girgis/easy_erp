import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/bloc_observer.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/helper/routes.dart';
import 'package:easy_erp/data/models/customer_model/customer_model.dart';
import 'package:easy_erp/data/models/printerModel/printer_model.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo_implementation.dart';
import 'package:easy_erp/data/repositories/item_repository/item_repo_implementation.dart';
import 'package:easy_erp/data/repositories/login_repository/login_repo_imp.dart';
import 'package:easy_erp/data/repositories/paid_repository/paid_repo_imp.dart';
import 'package:easy_erp/data/repositories/payer_type_repository/payer_type_repo_imp.dart';
import 'package:easy_erp/data/repositories/reciept_repository/reciept_repo_imp.dart';
import 'package:easy_erp/data/repositories/return_repository/return_repo_imp.dart';
import 'package:easy_erp/l10n/l10n.dart';
import 'package:easy_erp/presentation/Login/view_models/cubits/login_cubit/login_cubit.dart';
import 'package:easy_erp/presentation/cubits/paid_cubit/paid_cubit.dart';
import 'package:easy_erp/presentation/cubits/payer_type_cubit/payer_type_cubit.dart';
import 'package:easy_erp/presentation/cubits/reciept_cubit/reciept_cubit.dart';
import 'package:easy_erp/presentation/cubits/return_cubit/return_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/helper/app_routing.dart';
import 'data/models/item_model/item_model.dart';
import 'data/models/user/user_model.dart';
import 'data/providers/localization/localization_provider.dart';
import 'data/repositories/invoice_repository/invoice_repo_imp.dart';
import 'data/repositories/payment_type_repository/payment_type_repo_implementation.dart';
import 'data/services/local/shared_pref.dart';
import 'presentation/cubits/addItem_cubit/add_item_cubit.dart';
import 'presentation/cubits/customer_cubit/customer_cubit.dart';
import 'presentation/cubits/invoice_cubit/invoice_cubit.dart';
import 'presentation/cubits/item_cubit/item_cubit.dart';
import 'presentation/cubits/payment_type_cubit/payment_type_cubit.dart';

// import 'package:path_provider/path_provider.dart' as path_provider;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  /// Initialize SharedPref
  await SharedPref.init();

  String languageCode = SharedPref.get(key: 'languageCode') ?? 'ar';

  ///Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  await Hive.openBox<ItemModel>('itemBox');
  Hive.registerAdapter(CustomerModelAdapter());
  await Hive.openBox<CustomerModel>('customerBox');
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  Hive.registerAdapter(PrinterModelAdapter());
  await Hive.openBox<PrinterModel>('printerBox');

  ///setup DI for the App ,
  setupServiceLocatorByGetIt();

  runApp(MyApp(
    language: languageCode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.language,
  });
  final String language;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => LanguageProvider(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(
                getIt.get<LoginRepoImplementation>(),
              ),
            ),
            BlocProvider(
                create: (context) => CustomerCubit(
                      customerRepo: getIt.get<CustomerRepoImplementation>(),
                    )
                      ..getCustomerGroups()
                      ..getCustomers()),
            BlocProvider(
              create: (context) =>
                  GetItemCubit(itemRepo: getIt.get<ItemRepoImplementation>())
                    ..getItems(),
            ),
            BlocProvider(
              create: (context) => InvoiceCubit(
                invoiceRepo: getIt.get<InvoiceRepoImplementation>(),
              )..getInvoices(),
            ),
            BlocProvider(
                create: (context) => Returncubit(
                      returnRepo: getIt.get<ReturnRepoImplementation>(),
                    )..getReturns()),
            BlocProvider(
                create: (context) => Recieptcubit(
                      recieptRepo: getIt.get<RecieptRepoImplementation>(),
                    )..getReciepts()),
            BlocProvider(
                create: (context) => Paidcubit(
                      paidRepo: getIt.get<PaidRepoImplementation>(),
                    )..getPaids()),
            BlocProvider(
              create: (context) => getIt.get<AddItemCubit>(),
            ),
            BlocProvider(
                create: (context) =>
                    PaymentTypeCubit(getIt.get<PaymentTypeRepoImp>())),
            BlocProvider(
                create: (context) =>
                    PayerTypeCubit(getIt.get<PayerTypeRepoImp>())),
          ],
          child: Builder(builder: (context) {
            var languagesProvider = Provider.of<LanguageProvider>(context);

            return MaterialApp(
              navigatorKey: navigatorKey,
              initialRoute: AppRouters.kSplash,
              onGenerateRoute: Routes.generateRoute,
              debugShowCheckedModeBanner: false,
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: languagesProvider.locale,
              title: 'Easy ERP',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                scaffoldBackgroundColor: AppColors.primaryColorBlue,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColorBlue),
              ),
            );
          }),
        );
      },
    );
  }
}

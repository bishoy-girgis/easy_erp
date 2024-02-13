import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/core/helper/bloc_observer.dart';
import 'package:easy_erp/core/helper/locator.dart';
import 'package:easy_erp/data/repositories/customer_repository/customer_repo_implementation.dart';
import 'package:easy_erp/data/repositories/item_repository/item_repo_implementation.dart';
import 'package:easy_erp/data/repositories/login_repository/login_repo_imp.dart';
import 'package:easy_erp/l10n/l10n.dart';
import 'package:easy_erp/presentation/Home/view_models/addItem_cubit/cubit/add_item_cubit.dart';
import 'package:easy_erp/presentation/Home/view_models/customer_cubit/customer_cubit.dart';
import 'package:easy_erp/presentation/Login/view_models/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/helper/app_routing.dart';
import 'data/providers/localization/localization_provider.dart';
import 'data/services/local/shared_pref.dart';
import 'presentation/Home/view_models/item_cubit/item_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  Bloc.observer = MyBlocObserver();
  String languageCode = SharedPref.get(key: 'languageCode') ?? 'ar';
  // var status = await Permission.camera.request();
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
              create: (context) => GetCustomerCubit(
                customerRepo: getIt.get<CustomerRepoImplementation>(),
              )..getCustomers(),
            ),
            BlocProvider(
              create: (context) =>
                  GetItemCubit(itemRepo: getIt.get<ItemRepoImplementation>())
                    ..getItems(),
            ),
            BlocProvider(
              create: (context) => getIt.get<AddItemCubit>(),
            ),
          ],
          child: Builder(builder: (context) {
            var languagesProvider = Provider.of<LanguageProvider>(context);

            return MaterialApp.router(
              routerConfig: AppRouters.router,
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

import 'package:easy_erp/core/helper/app_colors.dart';
import 'package:easy_erp/data/providers/login/login_provider.dart';
import 'package:easy_erp/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'core/helper/app_routing.dart';
import 'data/providers/localization/localization_provider.dart';
import 'data/services/local/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  String languageCode = SharedPref.get(key: 'languageCode');

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
              ChangeNotifierProvider(
                create: (context) => LoginProvider(),
              ),
            ],
            child: Builder(builder: (context) {
              var languagesProvider = Provider.of<LanguageProvider>(context);

              return MaterialApp.router(
                routerConfig: AppRouters.router,
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
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
                  scaffoldBackgroundColor: AppColors.primaryColorBlue,
                  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
              );
            }),
          );
        });
  }
}

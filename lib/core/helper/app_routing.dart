import 'package:easy_erp/presentation/Login/views/login_view.dart';
import 'package:easy_erp/presentation/Settings/views/settings_view.dart';
import 'package:easy_erp/presentation/Splash/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/Home/views/home_view.dart';

abstract class AppRouters {
  // GoRouter configuration
  static const kLogin = "/loginView";

  static const kHome = "/loginView/home";
  static const kSettings = "/settings";
  // static const kUserProfileScreen = "/UserProfileScreen";
  // static const kCardScreen = "/CardScreen";
  // static const kAllProductsScreen = "/AllProductsScreen";
  // static const kViewAllOnSaleProductsScreen = "/ViewAllOnSaleProductsScreen";

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: kLogin,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: kHome,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsView(),
      ),
      // GoRoute(
      //   path: kCardScreen,
      //   builder: (context, state) => const CardScreen(),
      // ),
      // GoRoute(
      //   path: kViewAllOnSaleProductsScreen,
      //   // name: "ViewAllOnSaleProductsScreen",
      //   builder: (context, state) {
      //     return const ViewAllOnSaleProductsScreen();
      //   },
      // ),
      // GoRoute(
      //   path: kAllProductsScreen,
      //   // name: "ViewAllOnSaleProductsScreen",
      //   builder: (context, state) {
      //     return AllProductsScreen();
      //   },
      // ),
      // GoRoute(
      //   path: kSearchView,
      //   builder: (context, state) => const SearchView(),
      // ),
    ],
  );
}

import 'package:easy_erp/presentation/Home/views/inner_views/add_items_view/add_items_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Login/views/login_view.dart';
import 'package:easy_erp/presentation/Settings/views/settings_view.dart';
import 'package:easy_erp/presentation/Splash/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/Home/views/home_view.dart';
import '../../presentation/Home/views/inner_views/invoices_view/invoices_view.dart';
import '../../presentation/Home/views/inner_views/items_view/items_view.dart';

abstract class AppRouters {
  // GoRouter configuration
  static const kLogin = "/loginView";

  static const kHome = "/loginView/home";
  static const kSettings = "/settings";
  static const kItems = "/loginView/home/items";
  static const kInvoices = "/loginView/home/invoices";
  static const kCreateInvoice = "/loginView/home/invoices/createInvoice";
  static const kAddItemsIntoInvoice =
      "/loginView/home/invoices/createInvoice/addItemsIntoInvoice";
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
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kHome,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: kItems,
        builder: (context, state) => const ItemsView(),
      ),
      GoRoute(
        path: kInvoices,
        builder: (context, state) => InvoicesView(),
      ),
      GoRoute(
        path: kCreateInvoice,
        // name: "ViewAllOnSaleProductsScreen",
        builder: (context, state) {
          return const CreateInvoiceView();
        },
      ),
      GoRoute(
        path: kAddItemsIntoInvoice,
        // name: "ViewAllOnSaleProductsScreen",
        builder: (context, state) {
          return const AddItemsView();
        },
      ),
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

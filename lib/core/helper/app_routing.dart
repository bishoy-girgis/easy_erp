import 'package:easy_erp/data/models/invoice_model/invoice_model.dart';
import 'package:easy_erp/data/models/item_model/item_model.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/add_items_view/add_items_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/customer_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/returns_view.dart';
import 'package:easy_erp/presentation/Login/views/login_view.dart';
import 'package:easy_erp/presentation/Settings/views/settings_view.dart';
import 'package:easy_erp/presentation/Splash/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/Home/views/home_view.dart';
import '../../presentation/Home/views/inner_views/invoices_view/details_view.dart';
import '../../presentation/Home/views/inner_views/invoices_view/invoices_view.dart';
import '../../presentation/Home/views/inner_views/items_view/items_view.dart';

abstract class AppRouters {
  // GoRouter configuration
  static const kLogin = "/loginView";
  static const kSplash = "/";

  static const kHome = "/home";
  static const kSettings = "/settings";
  static const kItems = "/loginView/home/items";
  static const kCustomers = "/loginView/home/customers";
  static const kReturns = "/loginView/home/returns";
  static const kInvoices = "/loginView/home/invoices";
  static const kCreateInvoice = "/loginView/home/invoices/createInvoice";
  static const kAddItemsIntoInvoice =
      "/loginView/home/invoices/createInvoice/addItemsIntoInvoice";
  static const kInvoiceDetailsView =
      "/loginView/home/invoices/invoiceShowDetails";
  // static const kCardScreen = "/CardScreen";
  // static const kAllProductsScreen = "/AllProductsScreen";
  // static const kViewAllOnSaleProductsScreen = "/ViewAllOnSaleProductsScreen";
  // static const kViewAllProductsScreen = "/ViewAllProductsScreen";

  static final router = GoRouter(
    initialLocation: kSplash,
    routes: [
      GoRoute(
        path: kSplash,
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
          return CreateInvoiceView();
        },
      ),
      GoRoute(
        path: kAddItemsIntoInvoice,
        // name: "ViewAllOnSaleProductsScreen",
        builder: (context, state) {
          return AddItemsView();
        },
      ),
      GoRoute(
        path: kCustomers,
        builder: (context, state) {
          return const CustomerView();
        },
      ),
      GoRoute(
        path: kReturns,
        builder: (context, state) {
          return ReturnsView();
        },
      ),
      GoRoute(
        path: kInvoiceDetailsView,
        builder: (context, state) {
          return InvoiceDetailsView(
            singleInvoiceItem: state.extra as InvoiceModel,
          );
        },
      ),
    ],
  );
}

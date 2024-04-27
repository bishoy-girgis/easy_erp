import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/presentation/Home/views/home_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/add_customer_view/add_customer_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/add_items_view/add_items_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/customer_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/invoices_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/items_view/items_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/create_paid.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/paid_view/paid_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/create_reciept.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/receipt_view/receipt_view.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/create_return.dart';
import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/returns_view.dart';
import 'package:easy_erp/presentation/Login/views/login_view.dart';
import 'package:easy_erp/presentation/Settings/views/settings_view.dart';
import 'package:easy_erp/presentation/Splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouters.kSplash:
        return MaterialPageRoute<dynamic>(
            builder: (context) => SplashView(), settings: routeSettings);
      case AppRouters.kLogin:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), settings: routeSettings);
      case AppRouters.kHome:
        return MaterialPageRoute(
            builder: (context) => const HomeView(), settings: routeSettings);
      case AppRouters.kSettings:
        return MaterialPageRoute(
            builder: (context) => const SettingsView(),
            settings: routeSettings);
      case AppRouters.kItems:
        return MaterialPageRoute(
            builder: (context) => const ItemsView(), settings: routeSettings);
      case AppRouters.kInvoices:
        return MaterialPageRoute(
            builder: (context) => const InvoicesView(), settings: routeSettings);
      case AppRouters.kCreateInvoice:
        return MaterialPageRoute(
            builder: (context) => const CreateInvoiceView(),
            settings: routeSettings);
      case AppRouters.kAddItemsIntoInvoice:
        return MaterialPageRoute(
            builder: (context) => const AddItemsView(), settings: routeSettings);
      case AppRouters.kCustomers:
        return MaterialPageRoute(
            builder: (context) => CustomerView(), settings: routeSettings);
      case AppRouters.kReturns:
        return MaterialPageRoute(
            builder: (context) => const ReturnsView(), settings: routeSettings);
      case AppRouters.kCreateReturn:
        return MaterialPageRoute(
            builder: (context) => const CreateReturnView(),
            settings: routeSettings);
      case AppRouters.kReciept:
        return MaterialPageRoute(
            builder: (context) => const ReceiptView(), settings: routeSettings);
      case AppRouters.kCreateReciept:
        return MaterialPageRoute(
            builder: (context) => const CreateReciept(),
            settings: routeSettings);
      case AppRouters.kPaid:
        return MaterialPageRoute(
            builder: (context) => const PaidView(), settings: routeSettings);
      case AppRouters.kCreatePaid:
        return MaterialPageRoute(
            builder: (context) => const CreatePaid(), settings: routeSettings);
      case AppRouters.kCreateNewCustomer:
        return MaterialPageRoute(
            builder: (context) => AddCustomerView(), settings: routeSettings);
      default:
        return MaterialPageRoute<dynamic>(
            builder: (context) => SplashView(), settings: routeSettings);
    }
  }
}

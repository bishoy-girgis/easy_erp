// import 'package:easy_erp/presentation/Home/views/inner_views/add_customer_view/add_customer_view.dart';
// import 'package:easy_erp/presentation/Home/views/inner_views/add_items_view/add_items_view.dart';
// import 'package:easy_erp/presentation/Home/views/inner_views/customer_view/customer_view.dart';
// import 'package:easy_erp/presentation/Home/views/inner_views/invoices_view/create_invoice.dart';
// import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/create_return.dart';
// import 'package:easy_erp/presentation/Home/views/inner_views/returns_view/returns_view.dart';
// import 'package:easy_erp/presentation/Login/views/login_view.dart';
// import 'package:easy_erp/presentation/Settings/views/settings_view.dart';
// import 'package:easy_erp/presentation/Splash/splash_view.dart';
// import 'package:go_router/go_router.dart';

// import '../../presentation/Home/views/home_view.dart';
// import '../../presentation/Home/views/inner_views/invoices_view/invoices_view.dart';
// import '../../presentation/Home/views/inner_views/items_view/items_view.dart';

// abstract class AppRouters {
//   // GoRouter configuration
//   static const kLogin = "/loginView";
//   static const kSplash = "/";
//   static const kHome = "/home";
//   static const kSettings = "/settings";
//   static const kItems = "$kHome/items";
//   static const kCustomers = "$kHome/customers";
//   static const kReturns = "$kHome/returns";
//   static const kCreateReturn = "$kReturns/createReturn";
//   static const kInvoices = "$kHome/invoices";
//   static const kCreateInvoice = "$kInvoices/createInvoice";
//   static const kAddItemsIntoInvoice =
//       "$kHome/invoices/createInvoice/addItemsIntoInvoice";
//   static const kInvoicePreviewPDFView = "$kHome/invoices/invoiceShowDetailsPDF";
//   static const kCreateNewCustomer = "$kCustomers/createNewCustomer";

//   static final router = GoRouter(
//     initialLocation: kSplash,
//     routes: [
//       GoRoute(
//         path: kSplash,
//         builder: (context, state) => SplashView(),
//       ),
//       GoRoute(
//         path: kLogin,
//         builder: (context, state) => const LoginView(),
//       ),
//       GoRoute(
//         path: kHome,
//         builder: (context, state) => const HomeView(),
//       ),
//       GoRoute(
//         path: kSettings,
//         builder: (context, state) => const SettingsView(),
//       ),
//       GoRoute(
//         path: kItems,
//         builder: (context, state) => ItemsView(),
//       ),
//       GoRoute(
//         path: kInvoices,
//         name: kInvoices,
//         builder: (context, state) => InvoicesView(),
//       ),
//       GoRoute(
//         path: kCreateInvoice,
//         builder: (context, state) {
//           return const CreateInvoiceView();
//         },
//       ),
//       GoRoute(
//         path: kAddItemsIntoInvoice,
//         // name: "ViewAllOnSaleProductsScreen",
//         builder: (context, state) {
//           return AddItemsView();
//         },
//       ),
//       GoRoute(
//         path: kCustomers,
//         builder: (context, state) {
//           return CustomerView();
//         },
//       ),
//       GoRoute(
//         path: kReturns,
//         builder: (context, state) {
//           return ReturnsView();
//         },
//       ),
//       GoRoute(
//         path: kCreateReturn,
//         builder: (context, state) {
//           return const CreateReturnView();
//         },
//       ),
//       // GoRoute(
//       //   path: kInvoicePreviewPDFView,
//       //   builder: (context, state) {
//       //     return PdfPreviewScreen(
//       //       invoiceModel: state.invoiceModel,
//       //     );
//       //   },
//       // ),
//       GoRoute(
//         path: kCreateNewCustomer,
//         builder: (context, state) {
//           return AddCustomerView();
//         },
//       ),
//     ],
//   );
// }

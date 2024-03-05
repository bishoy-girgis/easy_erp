import 'package:easy_erp/data/services/local/shared_pref.dart';

class AppConstants {
  static int whId = SharedPref.get(key: "whId");
  static int printerFormat = SharedPref.get(key: 'printerFormat');
  static double vat = SharedPref.get(key: "vat");
  static String userName = SharedPref.get(key: "userName");
  static int branchID = SharedPref.get(key: "branchID");
  static int ccid = SharedPref.get(key: "ccid");
  static int vatType = SharedPref.get(key: "VATType");

  static String baseUrl =
      SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";

  ///Authorization
  static const String LOGIN_AND_TOKEN = "/token";
  static String accessToken = SharedPref.get(key: "accessToken") ?? "";

  ///Invoices
  static const String POST_INVOICE = "/api/Invsave/Post";
  static const String PRINT_INVOICE_WITH_ITEMS =
      "/api/Printinvoice/printinvoice";

  /// Return
  static const String POST_Return = "/api/RtnInvsave/Post";

  static String GET_INVOICES = "/api/Invoices/getinvoices";

  ///Items
  static String GET_ITEMS = "/api/Items/getitems";
  static const String GET_PAYMENT_TYPE = "/api/Payments/getpaymentstypes";

  ///Customers
  static const String GET_CUSTOMERS = "/api/Values/getcustomers";
  static const String GET_CUSTOMER_GROUPS = "/api/Groups/getgroups";
  static const String POST_CUSTOMER = "/api/custsave/Post";

  static void updateValues() {
    whId = SharedPref.get(key: "whId");
    vat = SharedPref.get(key: "vat");
    userName = SharedPref.get(key: "userName");
    branchID = SharedPref.get(key: "branchID");
    ccid = SharedPref.get(key: "ccid");
    vatType = SharedPref.get(key: "VATType");
    baseUrl = SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";
    accessToken = SharedPref.get(key: "accessToken");
  }
}

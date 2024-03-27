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

  static String branchName = SharedPref.get(key: "branchName") ?? "";
  static String branchAddress = SharedPref.get(key: "branchAddress") ?? "";
  static String taxNumber = SharedPref.get(key: "taxNumber") ?? "";
  static String notes = SharedPref.get(key: "notes") ?? "";

  ///Authorization
  static const String LOGIN_AND_TOKEN = "/token";
  static String accessToken = SharedPref.get(key: "accessToken") ?? "";

  ///Invoices
  static const String POST_INVOICE = "/api/Invsave/Post";
  static const String PRINT_INVOICE_WITH_ITEMS =
      "/api/Printinvoice/printinvoice";
  static String GET_INVOICES = "/api/Invoices/getinvoices";

  /// Return
  static const String POST_Return = "/api/RtnInvsave/Post";
  static String GET_Returns = "/api/RtnInvoices/getRtninvoices";
  static const String PRINT_Return_WITH_ITEMS =
      "/api/PrintRtninvoice/printRtninvoice";

  /// Reciept
  static const String POST_Reciept = "/api/RecIns/Post";
  static String GET_Reciepts = "/api/GetRec/getrec";

  /// Paid
  static const String POST_Paid = "/api/payIns/Post";
  static String GET_Paids = "/api/GetRec/getpay";

  ///Items
  static String GET_ITEMS = "/api/Items/getitems";
  static const String GET_PAYMENT_TYPE = "/api/Payments/getpaymentstypes";

  ///Payer Type
  static const String GET_PAYER_TYPE = "/api/Charts/GetCharts";

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

  static void updateSettingValues() {
    baseUrl = SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";
    branchName = SharedPref.get(key: "branchName") ?? "";
    branchAddress = SharedPref.get(key: "branchAddress") ?? "";
    taxNumber = SharedPref.get(key: "taxNumber") ?? "";
    notes = SharedPref.get(key: "notes") ?? "";
  }
}

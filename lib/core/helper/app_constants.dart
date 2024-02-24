import 'package:easy_erp/data/models/user/user_model.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppConstants {
  static final int whId = SharedPref.get(key: "whId");
  static final double vat = SharedPref.get(key: "vat");
  static final String userName = SharedPref.get(key: "userName");
  static final int branchID = SharedPref.get(key: "branchID");
  static final int ccid = SharedPref.get(key: "ccid");
  static String baseUrl =
      SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";

  ///Authorization
  static const String LOGIN_AND_TOKEN = "/token";
  static final String accessToken = SharedPref.get(key: "accessToken") ?? "";

  ///Invoices
  static const String POST_INVOICE = "/api/Invsave/Post";
  static String GET_INVOICES =
      "/api/Invoices/getinvoices?username=$userName&Branchid=$branchID";

  ///Items
  static String GET_ITEMS = "/api/Items/getitems?whid=$whId";
  static const String GET_PAYMENT_TYPE = "/api/Payments/getpaymentstypes";

  ///Customers
  static const String GET_CUSTOMERS = "/api/Values/getcustomers";
  static const String GET_CUSTOMER_GROUPS = "/api/Groups/getgroups";
  static const String POST_CUSTOMER = "/api/custsave/Post";
}

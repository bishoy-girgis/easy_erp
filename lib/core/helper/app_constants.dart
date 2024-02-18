import 'package:easy_erp/data/services/local/shared_pref.dart';

class AppConstants {
  static final String accessToken = SharedPref.get(key: "accessToken");
  static final int whId = SharedPref.get(key: "whId");
  static final double vat = SharedPref.get(key: "vat");

  static String baseUrl =
      SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";
  static DateTime dateTime = DateTime.now();
  static const String LOGIN_AND_TOKEN = "/token";
  // static const String POST_INVOICE = "/api/Invsave/Post";
  static String POST_INVOICE_WITH_PARAMETERS =
      "/api/Invsave/Post?date=02/02/2024&custid=1&invtype=2&user=mostafa&whid=1&ccid=1&branchid=1&netvalue=40.00&TaxAdd=20.00&FinalValue=60.00&Payid=1&bankDtlId=1";
  static const String GET_CUSTOMERS = "/api/Values/getcustomers";
  static String GET_ITEMS = "/api/Items/getitems?whid=$whId";
  static const String GET_PAYMENT_TYPE = "/api/Payments/getpaymentstypes";
}

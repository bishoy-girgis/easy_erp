import 'package:easy_erp/data/services/local/shared_pref.dart';

class AppConstants {
  static final String accessToken = SharedPref.get(key: "accessToken");
  static final int whId = SharedPref.get(key: "whId");
  static String baseUrl =
      SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";

  static const String LOGIN_AND_TOKEN = "/token";
  static const String GET_CUSTOMERS = "/api/Values/getcustomers";
  static String GET_ITEMS = "/api/Items/getitems?whid=$whId";
}

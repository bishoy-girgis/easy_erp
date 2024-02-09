import 'package:easy_erp/data/services/local/shared_pref.dart';

class AppConstants {
  static const String baseUrl = "http://95.216.193.252:600";
  static const String LOGIN_AND_TOKEN = "/token";
  static const String GET_CUSTOMERS = "/api/Values/getcustomers";
  static String accessToken = SharedPref.get(key: "accessToken") ?? "";
}

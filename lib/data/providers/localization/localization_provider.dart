import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/local/shared_pref.dart';

class LanguageProvider extends ChangeNotifier {
  // LocaleSharedPreferences localeSharedPref = LocaleSharedPreferences();
  Locale _locale = Locale(Intl.getCurrentLocale());
  Locale get locale => _locale;

  void setLocale(String languageCode) {
    log("setLocaleEn");
    // if (languageCode.isEmpty) {
    //   languageCode = 'en';
    // }
    _locale = Locale(languageCode);
    SharedPref.set(key: "languageCode", value: languageCode);
    notifyListeners();
  }
}

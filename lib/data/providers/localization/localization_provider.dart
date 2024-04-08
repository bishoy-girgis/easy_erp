import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/local/shared_pref.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = Locale( SharedPref.get(key: 'languageCode') ?? 'ar');
  Locale get locale => _locale;

  void setLocale(String languageCode) {
    log("setLocale ${languageCode}");
    if (languageCode.isEmpty) {
      languageCode = 'ar';
    }
    _locale = Locale(languageCode);
    SharedPref.set(key: "languageCode", value: languageCode);
    notifyListeners();
  }
}

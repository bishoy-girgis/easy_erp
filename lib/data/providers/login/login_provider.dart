import 'package:easy_erp/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isVisability = false;
  get isVisability {
    return _isVisability;
  }

  void changeVisability() {
    _isVisability = !_isVisability;
    notifyListeners();
  }
}

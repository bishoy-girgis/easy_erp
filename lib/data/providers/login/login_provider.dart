import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/api_services/api_service.dart';

// class LoginProvider extends ChangeNotifier {
//   bool _isVisability = false;
//   get isVisability {
//     return _isVisability;
//   }

//   void changeVisability() {
//     _isVisability = !_isVisability;
//     notifyListeners();
//   }

  // Future<void> loginUser(String username, String password) async {
  //   try {
  //     final response = await ApiService(Dio()).postData(
  //       endpoint: "/login", // replace with your API endpoint
  //       data: {
  //         'username': username,
  //         'password': password,
  //       },
  //     );
  //     print('Response: ${response.data}');
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error: $error');
  //     notifyListeners();
  //   }
  // }
// }

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../data/services/local/shared_pref.dart';

class ApiService {
   String get _baseUrl {
    return SharedPref.get(key: "baseUrl") ?? "http://sun.dyndns-office.com:600";
  }
  Dio dio;
  ApiService(this.dio);
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    var body,
  }) async {
    debugPrint(_baseUrl);
    var headers = {
      'Authorization': 'Bearer ${AppConstants.accessToken}',
    };
    var response = await dio.get('$_baseUrl$endPoint',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers));
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required var body,
  }) async {
    debugPrint(_baseUrl);

    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: headers,
      queryParameters: queryParameters,
    ));
    var response = await dio.post(endPoint,
        data: body.keys
            .map((key) => "$key=${Uri.encodeComponent(body[key])}")
            .join("&"));
    return response.data;
  }

  Future<dynamic> postBody({
    Object? data,
    Map<String, dynamic>? queryParameters,
    required String endPoint,
  }) async {
    debugPrint(_baseUrl);

    var dataa = json.encode(data);
    debugPrint('dataa');
    debugPrint(dataa);
    var headers = {
      'Authorization': 'Bearer ${AppConstants.accessToken}',
    };
    var response = await dio.request(
      AppConstants.baseUrl + endPoint,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      queryParameters: queryParameters,
      data: dataa,
    );
    if (response.statusCode == 200) {
      debugPrint("json.encode(response.data)");
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return response.data;
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../data/services/local/shared_pref.dart';

class ApiService {
   String get _baseUrl {
    return SharedPref.get(key: "baseUrl") ?? "http://95.216.193.252:600";
  }
  Dio dio;
  ApiService(this.dio);
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    var body,
  }) async {
    var headers = {
      'Authorization': 'Bearer ${AppConstants.accessToken}',
    };
    var response = await dio.get('$_baseUrl$endPoint',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers));
    interceptor();
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required var body,
  }) async {
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: headers,
      queryParameters: queryParameters,
    ));
    var response = await dio.post(endPoint,
        data: body.keys
            .map((key) => "$key=${Uri.encodeComponent(body[key])}")
            .join("&"));
    interceptor();
    return response.data;
  }

  Future<dynamic> postBody({
    Object? data,
    Map<String, dynamic>? queryParameters,
    required String endPoint,
  }) async {
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
    interceptor();
    return response.data;
  }

interceptor(){
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );
}
}

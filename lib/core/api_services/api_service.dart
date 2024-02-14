import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/app_constants.dart';

class ApiService {
  final _baseUrl = AppConstants.baseUrl;
  Dio dio;
  ApiService(this.dio);
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    var body,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer ${AppConstants.accessToken}';
    var response = await dio.get(
      '$_baseUrl$endPoint',
      queryParameters: queryParameters,
      data: body,
    );
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
    return response.data;
  }

  Future<Map<String, dynamic>> postBody({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required var body,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer ${AppConstants.accessToken}';
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: headers,
      queryParameters: queryParameters,
    ));
    var response = await dio.post(
      endPoint,
      data: body,
    );
    return response.data;
  }

  // Future<Map<String, dynamic>> put({
  //   required String endPoint,
  //   Map<String, dynamic>? headers,
  //   Map<String, dynamic>? queryParameters,
  //   required var body,
  // }) async {
  //   dio = Dio(BaseOptions(
  //     baseUrl: _baseUrl,
  //     headers: headers,
  //     queryParameters: queryParameters,
  //   ));
  //   var response = await dio.put(endPoint,
  //       data: body.keys
  //           .map((key) => "$key=${Uri.encodeComponent(body[key])}")
  //           .join("&"));
  //   return response.data;
  // }
}

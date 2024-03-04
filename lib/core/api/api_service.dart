import 'dart:convert';
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
    var headers = {
      'Authorization': 'Bearer ${AppConstants.accessToken}',
      // 'Authorization': 'Bearer ${SharedPref.get(key:"accessToken")}',
    };
    // dio.options.headers['Authorization'] = 'Bearer ${AppConstants.accessToken}';
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
    var dataa = json.encode(data);
    print('dataa');
    print(dataa);
    var headers = {
      'Authorization': 'Bearer ${AppConstants.accessToken}',
    };
    var response = await dio.request(
      '${AppConstants.baseUrl + endPoint}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      queryParameters: queryParameters,
      data: dataa,
    );
    if (response.statusCode == 200) {
      print("json.encode(response.data)");
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
    return response.data;
  }

  // Future<dynamic> postData({
  //   // required String apiUrl,
  //   dynamic body,
  //   // String? token,
  // }) async {
  //   Map<String, String> headers = {};

  //   headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${AppConstants.accessToken}'
  //   };
  //   //headers.addAll({'Authorization': 'Bearer $token'});

  //   http.Response response = await http.post(
  //     Uri.parse(
  //         'http://95.216.193.252:600/api/Invsave/Post?date=05/28/2024&custid=1&invtype=2&user=mostafa&whid=1&ccid=1&branchid=1&netvalue=40.00&TaxAdd=20.00&FinalValue=60.00&Payid=1&bankDtlId=1'),
  //     body: body,
  //     headers: headers,
  //   );
  //   print("in api file on post method................................ ");
  //   print(response.statusCode);
  //   print(response.headers);
  //   print(response.body);
  //   print(".......................................................... ");

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> data = jsonDecode(response.body);

  //     return data;
  //   } else {
  //     return throw Exception(
  //         "There is PROBLEM in Status Code in POST Method is =! 200 ====>>>>>${response.statusCode} ,,,,, ${jsonDecode(response.body)} ");
  //   }
  // }

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

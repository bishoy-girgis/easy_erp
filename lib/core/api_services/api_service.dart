import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/app_constants.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  Dio dio;
  ApiService(this.dio);
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    print("In GET API SERVICE");
    var response = await dio.get('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? headers,
    required var body,
  }) async {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: headers,
    ));
    var response = await dio.post(endPoint,
        data: body.keys
            .map((key) => "$key=${Uri.encodeComponent(body[key])}")
            .join("&"));
    return response.data;
  }

  // Future<Map<String, dynamic>> postData(
  //     {required String endpoint,
  //     required Map<String, dynamic> data,
  //     Map<String, dynamic>? headers}) async {
  //   _dio = Dio(BaseOptions(
  //     baseUrl: 'https://example.com/api',
  //     headers: headers,
  //   ));

  //   Response response = await _dio.post(
  //     endpoint,
  //     data: data,
  //   );

  //   return response.data;
  // }
}

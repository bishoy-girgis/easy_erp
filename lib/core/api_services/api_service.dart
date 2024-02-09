import 'package:dio/dio.dart';
import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';

class ApiService {
  final _baseUrl = AppConstants.baseUrl;
  Dio dio;
  ApiService(this.dio);
  Future<dynamic> get({
    required String endPoint,
    var body,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer ${AppConstants.accessToken}';
    var response = await dio.get(
      '$_baseUrl$endPoint',
      data: body,

      // options: Options().headers!['Authorization'] = '7RvCv0Kq1ZqPXXRWGWZ60ilMw-qVOoPv1DjB9_K54SCFWrKkOqiRt9LVq2cFkfNk4lxJ2cRbKc9t7Tp7GKe3TKSvYLnRDOxUvLOpjRGHPko0tl__4IxM9fa2KHciW3oVTbZfL1PzidQEBKG4XcTnG5hfS4HPeYivrODARQF9noBL6HCvscs3r-Yze8ervAh6a2cVdqttIeLcuo-0Bujzpw',
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? headers,
    required var body,
  }) async {
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
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

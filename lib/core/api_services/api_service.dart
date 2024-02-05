import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  Dio _dio;
  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    print("In GET API SERVICE");
    var response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }

  // Future<Map<String, dynamic>> post({
  //   required String endPoint,
  //   Map<String, dynamic>? headers,
  //   required Map<String, dynamic> body,
  // }) async {
  //   _dio = Dio(BaseOptions(
  //     baseUrl: 'https://example.com/api',
  //     headers: headers,
  //   ));
  //   var response = await _dio.post('$endPoint', data: body);
  //   return response.data;
  // }
  Future<dynamic> postData(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? headers}) async {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://example.com/api',
      headers: headers,
    ));
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );

      return response.data;
    } catch (error) {
      // You can handle errors as needed
      print('Error: $error');
      throw Exception('Failed to post data');
    }
  }
}

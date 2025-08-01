import 'package:dio/dio.dart';

class DioClient {
  Dio get dio => _initDio();

  Dio _initDio() {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    return dio;
  }
}
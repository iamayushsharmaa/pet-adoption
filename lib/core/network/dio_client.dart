import 'package:dio/dio.dart';

class DioClient {
  static Dio create() {
    final options = BaseOptions(
      baseUrl: 'https://6857a33021f5d3463e55b51a.mockapi.io/petadoption/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}

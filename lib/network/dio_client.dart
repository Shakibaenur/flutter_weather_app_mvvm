
import 'package:dio/dio.dart';
import '../config/build_config.dart';
import 'api_interceptor.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _dioClient;
  }

  Dio get client => _dio;

  DioClient._internal() {
    var options = BaseOptions(
      baseUrl: BuildConfig.instance.config.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
    _dio.interceptors.addAll(getInterceptors());
  }
}
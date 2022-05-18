import 'dart:developer';

import 'package:dio/dio.dart';

import '../../data/data_source/local/preferences_local_data_source.dart';
import '../constants/endpoints.dart';

class AppInterceptor extends Interceptor {
  final PreferencesLocalDataSource localDataSource;
  AppInterceptor({
    required this.localDataSource,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!EndPoints.excludeEndpoints.contains(options.path)) {
      final token = await localDataSource.token;
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('$err');
    handler.next(err);
  }
}

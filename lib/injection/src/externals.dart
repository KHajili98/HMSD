import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/constants/endpoints.dart';
import '../../core/network/app_interceptor.dart';
import '../../data/data_source/local/preferences_local_data_source.dart';
import '../../main_common.dart';

final getIt = GetIt.instance;

Future<void> init(Environment environment) async {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton<PreferencesLocalDataSource>(
    () => PreferencesLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        baseUrl: environment == Environment.dev
            ? EndPoints.devBaseUrl
            : EndPoints.prodBaseUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
      )
      ..interceptors.addAll([
        if (environment == Environment.dev)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
      ]),
  );

  getIt.get<Dio>()
    ..options
    ..interceptors.add(
      getIt.get<AppInterceptor>(),
    );
}

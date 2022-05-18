import 'package:get_it/get_it.dart';

import '../../core/network/app_interceptor.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => AppInterceptor(localDataSource: getIt()),
  );
}

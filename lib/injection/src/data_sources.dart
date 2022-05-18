import 'package:get_it/get_it.dart';

import '../../data/data_source/remote/beers_data_source.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<BeersDataSource>(
    () => BeersDataSourceImpl(getIt()),
  );
}

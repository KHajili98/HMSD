import 'package:get_it/get_it.dart';

import '../../data/repositories/beers_repository_impl.dart';
import '../../domain/repositories/beers_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<BeersRepository>(
    () => BeersRepositoryImpl(beersDataSource: getIt()),
  );
}

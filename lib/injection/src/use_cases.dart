import '../../domain/use_cases/get_beers.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(
    () => GetBeers(
      beersRepository: getIt(),
    ),
  );
}

import '../entities/beers.dart';

import '../../core/either.dart';
import '../../core/error/failure.dart';

abstract class BeersRepository {
  Future<Either<Failure, List<Beers>>> fetchBeers(
    int page,
    int perPage,
  );
}

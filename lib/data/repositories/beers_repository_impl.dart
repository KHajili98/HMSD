import '../../domain/entities/beers.dart';
import 'package:dio/dio.dart';

import '../../core/either.dart';
import '../../core/error/failure.dart';
import '../../domain/repositories/beers_repository.dart';
import '../data_source/remote/beers_data_source.dart';

class BeersRepositoryImpl implements BeersRepository {
  const BeersRepositoryImpl({required this.beersDataSource});

  final BeersDataSource beersDataSource;

  @override
  Future<Either<Failure, List<Beers>>> fetchBeers(int page, int perPage) async {
    try {
      return Success(await beersDataSource.fetchBeers(page, perPage));
    } on DioError catch (e) {
      if (e.response?.data != null) {
        return Error(Failure.network(e.message));
      } else {
        return const Error(Failure.network());
      }
    } catch (e) {
      return const Error(Failure.other());
    }
  }
}

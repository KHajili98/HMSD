import 'dart:async';

import '../entities/beers.dart';
import 'package:equatable/equatable.dart';

import '../../core/either.dart';
import '../../core/error/failure.dart';
import '../../core/use_case/use_case.dart';
import '../repositories/beers_repository.dart';

class GetBeers extends UseCase<List<Beers>, BeersParams> {
  final BeersRepository beersRepository;

  GetBeers({required this.beersRepository});

  @override
  Future<Either<Failure, List<Beers>>> call(BeersParams params) {
    return beersRepository.fetchBeers(params.page, params.perPage);
  }
}

class BeersParams extends Equatable {
  final int page;
  final int perPage;

  const BeersParams({
    required this.page,
    required this.perPage,
  });

  @override
  List<Object?> get props => [page, perPage];
}

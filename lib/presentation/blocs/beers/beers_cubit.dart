import '../../../core/bloc/pagination_state.dart';
import '../../../domain/entities/beers.dart';
import '../../../domain/use_cases/get_beers.dart';
import 'package:bloc/bloc.dart';

import '../../../data/data_source/local/preferences_local_data_source.dart';

typedef BookingsState = PaginationState<List<Beers>, String>;

class BeersCubit extends Cubit<BookingsState> {
  BeersCubit({required this.localDataSource, required this.getBeers})
      : super(
          const PaginationState(data: []),
        );

  final GetBeers getBeers;
  final PreferencesLocalDataSource localDataSource;
  int _currentPage = 0;
  bool isBusy = false;

  Future<void> fetchBeers() async {
    _currentPage = 1;
    emit(state.copyWith(isInProgress: true, hasReachedToEnd: false));

    final result = await getBeers(BeersParams(page: _currentPage, perPage: 10));

    await result.when(
      error: (_) => emit(state.copyWith(isFailure: true)),
      success: (result) async {
        if (result.isEmpty) {
          emit(state.copyWith(isSuccess: true, isEmpty: true));
        } else {
          List<Beers> favorites = await localDataSource.favorites;

          List<Beers> response = [...result];
          for (var fav in favorites) {
            for (var element in response) {
              if (fav.id == element.id) {
                element.isFavorite = true;
              }
            }
          }

          emit(state.copyWith(isSuccess: true, data: response));
        }
      },
    );
  }

  Future<void> addFavorite(Beers item) async {
    await localDataSource.addFavorite(item);
  }

  Future<void> removeFavorite(Beers item) async {
    await localDataSource.removeFavorite(item);
  }

  Future<void> fetchBeersPagination() async {
    if (state.isInAgainProgress || state.hasReachedToEnd || isBusy) {
      return;
    }
    isBusy = true;

    emit(state.copyWith(isInAgainProgress: true, isSuccess: true));

    if ((state.data!.length % 10) == 0) {
      _currentPage++;
    } else {
      emit(state.copyWith(hasReachedToEnd: true, isSuccess: true));
      return;
    }

    final result = await getBeers(BeersParams(page: _currentPage, perPage: 10));

    result.when(
      error: (_) {
        emit(state.copyWith(isFailure: true));
      },
      success: (result) async {
        List<Beers> favorites = await localDataSource.favorites;

        List<Beers> response = [...result];
        for (var fav in favorites) {
          for (var element in response) {
            if (fav.id == element.id) {
              element.isFavorite = true;
            }
          }
        }

        List<Beers> last = [...state.data!];

        last.addAll(response);

        emit(state.copyWith(isSuccess: true, data: last));
      },
    ).then((value) => isBusy = false);
  }
}

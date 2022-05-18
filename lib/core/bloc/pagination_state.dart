import 'package:equatable/equatable.dart';

class PaginationState<Success, Error> extends Equatable {
  final bool isInProgress;
  final bool isInAgainProgress;
  final bool hasReachedToEnd;
  final bool isFailure;
  final bool isInternetError;
  final bool isSuccess;
  final bool isEmpty;
  final Success? data;
  final Error? error;

  const PaginationState({
    this.isInProgress = false,
    this.isInAgainProgress = false,
    this.hasReachedToEnd = false,
    this.isFailure = false,
    this.isInternetError = false,
    this.isSuccess = false,
    this.isEmpty = false,
    this.data,
    this.error,
  });

  PaginationState<Success, Error> copyWith({
    final bool? isInProgress,
    final bool? isInAgainProgress,
    final bool? hasReachedToEnd,
    final bool? isFailure,
    final bool? isInternetError,
    final bool? isSuccess,
    final bool? isEmpty,
    final Success? data,
    final Error? error,
  }) {
    return PaginationState(
      isInProgress: isInProgress ?? false,
      isInAgainProgress: isInAgainProgress ?? false,
      hasReachedToEnd: hasReachedToEnd ?? this.hasReachedToEnd,
      isFailure: isFailure ?? false,
      isInternetError: isInternetError ?? false,
      isSuccess: isSuccess ?? false,
      isEmpty: isEmpty ?? false,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isInProgress,
        isInAgainProgress,
        hasReachedToEnd,
        isFailure,
        isInternetError,
        isSuccess,
        isEmpty,
        error,
        data,
      ];

  @override
  bool? get stringify => true;
}

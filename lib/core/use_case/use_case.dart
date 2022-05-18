import 'dart:async';

import '../either.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  FutureOr<Either<Failure, Type>> call(Params params);
}

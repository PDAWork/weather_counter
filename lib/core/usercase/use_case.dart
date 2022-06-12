import 'package:dartz/dartz.dart';
import 'package:test_project/core/failure/failure.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

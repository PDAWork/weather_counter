import 'package:dartz/dartz.dart';
import 'package:test_project/core/failure/failure.dart';
import 'package:test_project/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather({
    required double latitude,
    required double longitude,
  });
}

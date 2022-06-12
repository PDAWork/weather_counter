import 'package:test_project/core/failure/exception.dart';
import 'package:test_project/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_project/core/platform/network_info.dart';
import 'package:test_project/data/datasource/weather_local_data_source.dart';
import 'package:test_project/data/datasource/weather_remote_data_source.dart';
import 'package:test_project/domain/repository/weather_repository.dart';
import 'package:test_project/domain/entities/weather_entity.dart';

class WeatherRepositoryIml implements WeatherRepository {
  final WeatherLocalDataSource localDataSource;
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryIml({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather =
            await remoteDataSource.getWeather(latitude, longitude);
        localDataSource.weatherToCache(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationWeather =
            await localDataSource.getLastWeatherFromChache();
        return Right(locationWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

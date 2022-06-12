import 'package:test_project/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_project/core/usercase/use_case.dart';
import 'package:test_project/domain/repository/weather_repository.dart';
import 'package:test_project/domain/entities/weather_entity.dart';

class GetWeather extends UserCase<WeatherEntity, WeatherParams> {
  final WeatherRepository weatherRepository;

  GetWeather(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherEntity>> call(WeatherParams params) async {
    return await weatherRepository.getWeather(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class WeatherParams {
  final double latitude;
  final double longitude;

  WeatherParams({required this.latitude, required this.longitude});
}

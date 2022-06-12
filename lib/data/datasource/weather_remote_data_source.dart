import 'package:dio/dio.dart';
import 'package:test_project/core/failure/exception.dart';
import 'package:test_project/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  //https://api.open-meteo.com/v1/forecast?latitude=55.7558&longitude=37.6176&current_weather=true
  Future<WeatherModel> getWeather(
    double latitude,
    double longitude,
  );
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    try {
      final response = await dio.get(
          'forecast?latitude=$latitude&longitude=$longitude&current_weather=true');
      return WeatherModel.fromJson(response.data['current_weather']);
    } on DioError {
      throw ServerException();
    }
  }
}

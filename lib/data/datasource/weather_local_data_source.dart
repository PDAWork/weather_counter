import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/failure/exception.dart';
import 'package:test_project/data/model/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeatherFromChache();
  Future<void> weatherToCache(WeatherModel weather);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherModel> getLastWeatherFromChache() {
    final jsonWeather = sharedPreferences.getString(CACHED_WEATHER);

    if (jsonWeather!.isNotEmpty) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonWeather)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> weatherToCache(WeatherModel weather) {
    final String jsonWeather = json.encode(weather);

    sharedPreferences.setString(CACHED_WEATHER, jsonWeather);
    return Future.value(jsonWeather);
  }
}

import 'package:test_project/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required time,
    required temperature,
  }) : super(
          temperature: temperature,
          time: time,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json['time'],
      temperature: json['temperature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature': temperature,
    };
  }
}

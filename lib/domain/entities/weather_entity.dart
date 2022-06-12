import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String time;
  final double temperature;

  const WeatherEntity({
    required this.time,
    required this.temperature,
  });

  factory WeatherEntity.empty() {
    return const WeatherEntity(time: '', temperature: 0);
  }

  @override
  List<Object?> get props => [
        time,
        temperature,
      ];
}

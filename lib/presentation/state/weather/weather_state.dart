part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  final WeatherEntity oldWeather;

  WeatherLoading(this.oldWeather);

  @override
  List<Object> get props => [oldWeather];
}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;

  WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}

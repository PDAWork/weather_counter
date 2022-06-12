import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_project/core/failure/failure.dart';
import 'package:test_project/domain/entities/weather_entity.dart';
import 'package:test_project/domain/usecase/get_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeather getWeather;

  WeatherCubit({required this.getWeather}) : super(WeatherEmpty());

  void loadedWeather() async {
    if (state is WeatherLoading) return;

    final currentState = state;

    var oldWeather = WeatherEntity.empty();

    if (currentState is WeatherLoaded) {
      oldWeather = currentState.weather;
    }

    emit(WeatherLoading(oldWeather));

    final failureOrWeather =
        await getWeather(WeatherParams(latitude: 55.75, longitude: 37.625));

    failureOrWeather.fold((error) => _mapFailureToMessage(error), (weather) {
      emit(WeatherLoaded(weather));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexcpected Error';
    }
  }
}

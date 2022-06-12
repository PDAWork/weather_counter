import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/platform/network_info.dart';
import 'package:test_project/data/datasource/weather_local_data_source.dart';
import 'package:test_project/data/datasource/weather_remote_data_source.dart';
import 'package:test_project/data/repository/weather_repository.dart';
import 'package:test_project/domain/repository/weather_repository.dart';
import 'package:test_project/domain/usecase/get_weather.dart';
import 'package:test_project/presentation/state/counter/counter_cubit.dart';
import 'package:test_project/presentation/state/weather/weather_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc/Cubit

  sl.registerFactory(() => CounterCubit());
  sl.registerFactory(() => WeatherCubit(getWeather: sl()));

  //UseCases

  sl.registerLazySingleton(() => GetWeather(sl()));

  //Repository

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryIml(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://api.open-meteo.com/v1/',
          connectTimeout: 1500,
          sendTimeout: 1500,
          receiveTimeout: 1500,
        ),
      ),
    ),
  );

  sl.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio(
        BaseOptions(
          baseUrl: 'https://api.open-meteo.com/v1/',
          connectTimeout: 1500,
          sendTimeout: 1500,
          receiveTimeout: 1500,
        ),
      ));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/common/theme.dart';
import 'package:test_project/domain/entities/weather_entity.dart';
import 'package:test_project/presentation/state/counter/counter_cubit.dart';
import 'package:test_project/presentation/state/weather/weather_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherEntity weatherEntity = WeatherEntity.empty();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return ThemeSwitchingArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Weather Counter'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  const Text('Press the icon to get your location'),
                  BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        CircularProgressIndicator();
                      }
                      if (state is WeatherLoaded) {
                        weatherEntity = state.weather;
                      }

                      return Text('${weatherEntity.temperature} C');
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('You have pushed the button this many times:'),
                  Text(context.read<CounterCubit>().count.toString()),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          context.read<WeatherCubit>().loadedWeather();
                        },
                        child: const Icon(Icons.cloud),
                      ),
                      AnimatedContainer(
                        // opacity: state is CounterMin ? 0 : 1,
                        duration: const Duration(milliseconds: 1500),
                        child: SizedBox(
                          width: state is CounterMax ? 0 : 55,
                          child: FloatingActionButton(
                            onPressed: () {
                              context.read<CounterCubit>().counterIncrement(
                                    ThemeModelInheritedNotifier.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light,
                                  );
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ThemeSwitcher(
                          clipper: const ThemeSwitcherCircleClipper(),
                          builder: (BuildContext context) {
                            return FloatingActionButton(
                              onPressed: () {
                                ThemeSwitcher.of(context).changeTheme(
                                  theme: ThemeModelInheritedNotifier.of(context)
                                              .theme
                                              .brightness ==
                                          Brightness.light
                                      ? darkTheme
                                      : lightTheme,
                                );
                              },
                              child: const Icon(Icons.palette),
                            );
                          }),
                      AnimatedContainer(
                        // opacity: state is CounterMin ? 0 : 1,
                        duration: const Duration(milliseconds: 1500),
                        child: SizedBox(
                          width: state is CounterMin ? 0 : 55,
                          child: FloatingActionButton(
                            onPressed: () {
                              context.read<CounterCubit>().counterDecriment(
                                    ThemeModelInheritedNotifier.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light,
                                  );
                            },
                            child: const Icon(Icons.remove),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

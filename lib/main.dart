import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/local_service.dart';
import 'package:test_project/presentation/pages/home.dart';
import 'package:test_project/presentation/state/counter/counter_cubit.dart';
import 'package:test_project/presentation/state/weather/weather_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData newTheme = ThemeData();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CounterCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<WeatherCubit>(),
        )
      ],
      child: ThemeProvider(
        initTheme: newTheme,
        builder: (context, myTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: myTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

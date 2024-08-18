import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/state/weather_state.dart';
import 'package:weather_app/constants.dart';

void main() {
  runApp(
    // ---------- Initializing Providers for State Management ----------
    MultiProvider(
      providers: [
        // ---------- WeatherState Provider ----------
        ChangeNotifierProvider(
          create: (_) => WeatherState(
            WeatherService(API_KEY),
            LocationService(API_KEY),
          ),
        ),
      ],
      // ---------- Root of the Application ----------
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

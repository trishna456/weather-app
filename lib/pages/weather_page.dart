import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
// api key

  final _weatherService = WeatherService('a68be96863e81680c1c00e641a278502');
  Weather? _weather;
  String _units = 'metric'; //default to metric

// fetch weather
  _fetchWeather() async {
    // get the current position
    Position position = await _weatherService.getCurrentPosition();

    try {
      // get weather for position
      final weather = await _weatherService.getWeatherByCoordinates(
          position.latitude, position.longitude, _units);

      setState(() {
        _weather = weather;
      });
    }
    // any errors
    catch (e) {
      print(e);
    }
  }

// weather animations
  String getWeatherAnimation(String? mainCondition) {
    debugPrint(mainCondition);
    if (mainCondition == null) {
      return 'assets/sunny.json'; // default set to sunny
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

// init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              setState(() {
                _units = _units == 'metric' ? 'imperial' : 'metric';
                _fetchWeather();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "Loading city..."),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //Lottie.asset('assets/thunder.json'),

            // temperature
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}

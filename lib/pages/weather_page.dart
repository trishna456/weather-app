import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/forecast_list.dart';
import 'package:weather_app/widgets/weather_animation.dart';
import 'package:weather_app/widgets/weather_info.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(API_KEY);
  final _locationService = LocationService(API_KEY);

  Weather? _weather;
  String _units = 'metric'; //default to metric
  final TextEditingController _cityController = TextEditingController();

// fetch weather based on city name or device location
  _fetchWeather() async {
    double lat;
    double lon;

    try {
      if (_cityController.text.isNotEmpty) {
        // If the user has entered a city name, fetch coordinates for that city
        final coordinates = await _locationService
            .getCoordinatesByCityName(_cityController.text);
        lat = coordinates['lat']!;
        lon = coordinates['lon']!;
      } else {
        // otherwise, fetch weather from the current device location
        Position position = await _locationService.getCurrentPosition();
        lat = position.latitude;
        lon = position.longitude;
      }

      // get weather
      final weather =
          await _weatherService.getWeatherByCoordinates(lat, lon, _units);

      setState(() {
        _weather = weather;
      });
    }
    // any errors
    catch (e) {
      throw Exception('Failed to load weather data');
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
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE, MMMM d').format(now);

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
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => _fetchWeather(),
            ),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Get Weather'),
            ),
            if (_weather != null) ...[
              // city name
              Text(_weather?.cityName ?? "Loading city..."),

              // current date and day
              Text(formattedDate),

              // animation
              WeatherAnimation(mainCondition: _weather?.mainCondition),

              WeatherInfo(weather: _weather!, units: _units),
              /*
              The ! operator in Dart is called the "null assertion operator."
              It is used to tell the Dart compiler that you are certain a value that is currently of a nullable type
              (Weather? in this case) is not null at the point where you are using it.

              When you see _weather!, it means that the code assumes that _weather is not null at that point.
              If _weather is actually null, the program will throw a runtime error
              (specifically a NullPointerException).
              */

              // Daily forecast
              Expanded(
                child: ForecastList(dailyForecast: _weather!.dailyForecast),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/forecast_list.dart';
import 'package:weather_app/widgets/input_row.dart';
import 'package:weather_app/widgets/main_weather_info.dart';
import 'package:weather_app/widgets/weather_info.dart';
import 'package:weather_app/widgets/custom_error_widget.dart';

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
  String? _error;
  final TextEditingController _cityController = TextEditingController();

// fetch weather based on city name or device location
  _fetchWeather() async {
    double lat;
    double lon;

    try {
      setState(() {
        _error = null; // Clear any previous error
      });
      if (_cityController.text.isNotEmpty) {
        // If the user has entered a city name, fetch coordinates for that city
        final coordinates = await _locationService
            .getCoordinatesByCityName(_cityController.text);
        lat = coordinates['lat']!;
        lon = coordinates['lon']!;
        // Clear the input field after getting the coordinates
        _cityController.clear();
      } else {
        debugPrint(_weather?.cityName);
        if (_weather?.cityName != null) {
          final coordinates = await _locationService
              .getCoordinatesByCityName(_weather!.cityName);
          lat = coordinates['lat']!;
          lon = coordinates['lon']!;
        } else {
          // otherwise, fetch weather from the current device location
          Position position = await _locationService.getCurrentPosition();
          lat = position.latitude;
          lon = position.longitude;
        }
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
      debugPrint('Failed to load weather data.');
      setState(() {
        _error =
            'Failed to load weather data. Please try again.'; // Set the error message
      });
      //throw Exception('Failed to load weather data');
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 9, 86, 145),
                Color.fromARGB(255, 12, 35, 54),
              ]),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  InputRow(
                    controller: _cityController,
                    fetchWeather: _fetchWeather,
                    units: _units,
                    onToggle: (selectedUnit) {
                      setState(() {
                        _units = selectedUnit;
                        _fetchWeather();
                      });
                    },
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 20),
                    CustomErrorWidget(
                      errorMessage: _error!,
                    ),
                  ] else if (_weather != null) ...[
                    Expanded(
                      child: Column(
                        children: [
                          MainWeatherInfo(
                            weather: _weather!,
                            units: _units,
                          ),
                          const SizedBox(height: 20),
                          WeatherInfo(weather: _weather!, units: _units),
                          Expanded(
                            child: ForecastList(
                                dailyForecast: _weather!.dailyForecast),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

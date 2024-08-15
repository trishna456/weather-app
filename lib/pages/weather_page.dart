import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService('a68be96863e81680c1c00e641a278502'); //api key

  final _locationService = LocationService('a68be96863e81680c1c00e641a278502');
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
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              //Lottie.asset('assets/thunder.json'),

              // temperature
              Text(
                  '${_weather?.temperature.round()}°${_units == 'metric' ? 'C' : 'F'}'),

              // feels like temperature
              Text(
                  'Feels like: ${_weather?.feelsLike.round()}°${_units == 'metric' ? 'C' : 'F'}'),

              // humidity
              Text('Humidity: ${_weather?.humidity}%'),

              // wind speed
              Text(
                  'Wind Speed: ${_weather?.windSpeed} ${_units == 'metric' ? 'm/s' : 'mph'}'),

              // sunrise
              Text(
                  'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(_weather!.sunrise * 1000).toLocal().toString().split(' ')[1]}'),

              // sunset
              Text(
                  'Sunset: ${DateTime.fromMillisecondsSinceEpoch(_weather!.sunset * 1000).toLocal().toString().split(' ')[1]}'),

              // Daily forecast
              Expanded(
                child: ListView.builder(
                  itemCount: _weather?.dailyForecast.length ?? 0,
                  itemBuilder: (context, index) {
                    if (index >= 6)
                      return null; //limiting to today + next 5 days
                    final daily = _weather!.dailyForecast[index];
                    final date =
                        DateTime.fromMillisecondsSinceEpoch(daily.date * 1000)
                            .toLocal()
                            .toString()
                            .split(' ')[0];
                    return ListTile(
                      title: Text(date),
                      subtitle: Text(daily.description),
                      trailing: Text('${daily.minTemp}° - ${daily.maxTemp}°'),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

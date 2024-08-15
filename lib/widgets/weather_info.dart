import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  final String units;

  const WeatherInfo({super.key, required this.weather, required this.units});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // temperature
        Text(
          '${weather.temperature.round()}°${units == 'metric' ? 'C' : 'F'}',
          style: const TextStyle(fontSize: 32),
        ),
        // feels like temperature
        Text(
          'Feels like: ${weather.feelsLike.round()}°${units == 'metric' ? 'C' : 'F'}',
          style: const TextStyle(fontSize: 16),
        ),
        // humidity
        Text('Humidity: ${weather.humidity}%',
            style: const TextStyle(fontSize: 16)),
        // wind speed
        Text(
          'Wind Speed: ${weather.windSpeed} ${units == 'metric' ? 'm/s' : 'mph'}',
          style: const TextStyle(fontSize: 16),
        ),
        // sunrise
        Text(
          'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000).toLocal().toString().split(' ')[1]}',
          style: const TextStyle(fontSize: 16),
        ),
        // sunset
        Text(
          'Sunset: ${DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000).toLocal().toString().split(' ')[1]}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

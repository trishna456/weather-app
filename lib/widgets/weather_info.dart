import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'weather_info_item.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  final String units;

  const WeatherInfo({super.key, required this.weather, required this.units});

  @override
  Widget build(BuildContext context) {
    final DateFormat hourFormat =
        DateFormat('h:mm'); // 5:53 format without AM/PM
    final DateFormat periodFormat = DateFormat('a'); // AM/PM format

    // Convert pressure from hPa to inHg
    final double pressureInHg = weather.pressure * 0.02953;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 79, 132),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WeatherInfoItem(
            icon: CupertinoIcons.sunrise,
            label: 'Sunrise',
            value: hourFormat.format(
                DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000)),
            unit: periodFormat
                .format(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000))
                .toLowerCase(),
          ),
          WeatherInfoItem(
            icon: CupertinoIcons.sunset,
            label: 'Sunset',
            value: hourFormat.format(
                DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000)),
            unit: periodFormat
                .format(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000))
                .toLowerCase(),
          ),
          WeatherInfoItem(
            icon: CupertinoIcons.drop,
            label: 'Humidity',
            value: '${weather.humidity}',
            unit: '%',
          ),
          WeatherInfoItem(
            icon: CupertinoIcons.wind,
            label: 'Wind',
            value: '${weather.windSpeed}',
            unit: units == 'metric' ? 'm/s' : 'mph',
          ),
          WeatherInfoItem(
            icon: CupertinoIcons.gauge,
            label: 'Pressure',
            value: pressureInHg.toStringAsFixed(2),
            unit: 'inHg',
          ),
        ],
      ),
    );
  }
}

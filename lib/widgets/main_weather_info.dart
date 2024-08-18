import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class MainWeatherInfo extends StatelessWidget {
  final Weather weather;
  final String units;

  const MainWeatherInfo({
    super.key,
    required this.weather,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MMMM d').format(now); // August 15
    final String formattedDay = DateFormat('EEEE').format(now); // Thursday
    final String finalFormattedDate = '$formattedDate | $formattedDay';
    // August 15 | Thursday

    return Column(
      children: [
        const SizedBox(height: 30), // for top padding
        // City Name
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text(
                '${weather.temperature.round()}',
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Positioned(
              top: 20, // Adjust the position as needed
              right: 1,
              child: Text(
                '°${units == 'metric' ? 'C' : 'F'}',
                style: const TextStyle(
                  fontSize: 24, // Smaller font size for the degree symbol
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),

        // Date and Day
        Text(
          finalFormattedDate,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}

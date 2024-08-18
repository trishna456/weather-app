import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/weather_animation.dart';

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

    // Capitalize the first letter of each word in the description
    final String capitalizedDescription = weather.description
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return Column(
      children: [
        const SizedBox(height: 15), // for top padding
        // City Name
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 28,
            //height: 1,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 28),
              child: Text(
                '${weather.temperature.round()}',
                style: const TextStyle(
                  fontSize: 100,
                  color: Color.fromARGB(255, 225, 226, 230),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Positioned(
              top: 25, // Adjust the position as needed
              right: 1,
              child: Text(
                '°${units == 'metric' ? 'C' : 'F'}',
                style: const TextStyle(
                  fontSize: 26, // Smaller font size for the degree symbol
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
            fontSize: 14,
            height: 0.1,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // animation
        WeatherAnimation(mainCondition: weather.mainCondition),
        const SizedBox(
          height: 15,
        ),
        Text(capitalizedDescription,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white70,
              fontFamily: 'Poppins',
            )),
      ],
    );
  }
}

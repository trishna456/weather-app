import 'package:flutter/material.dart';
import 'package:weather_app/models/daily_forecast_model.dart';

class ForecastList extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  const ForecastList({super.key, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyForecast.length,
      itemBuilder: (context, index) {
        if (index >= 6) return null; // limiting to today + next 5 days
        final daily = dailyForecast[index];
        final date = DateTime.fromMillisecondsSinceEpoch(daily.date * 1000)
            .toLocal()
            .toString()
            .split(' ')[0];

        return ListTile(
          title: Text(date),
          subtitle: Text(daily.description),
          trailing: Text('${daily.minTemp}° - ${daily.maxTemp}°'),
        );
      },
    );
  }
}

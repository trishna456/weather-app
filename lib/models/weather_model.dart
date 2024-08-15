import 'daily_forecast_model.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double feelsLike;
  final double humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final int visibility;
  final int sunrise;
  final int sunset;
  final double uvIndex;
  final List<DailyForecast> dailyForecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.uvIndex,
    required this.dailyForecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    /*
    The factory keyword in Dart is used to define a factory constructor.
    A factory constructor is a special type of constructor that is used to create an instance of a class,
    but unlike regular constructors, it can return an existing instance or a different instance based on some logic.

    In this case, Weather.fromJson is a factory constructor that creates a Weather instance from a JSON map.
    It is not an inbuilt function; rather, it is a custom constructor that we have defined for our Weather class.
    */
    List<DailyForecast> dailyForecast = (json['daily'] as List)
        .map((dailyJson) => DailyForecast.fromJson(dailyJson))
        .toList();

    return Weather(
      cityName: cityName,
      temperature: json['current']['temp'].toDouble(),
      mainCondition: json['current']['weather'][0]['main'],
      description: json['current']['weather'][0]['description'],
      feelsLike: json['current']['feels_like'].toDouble(),
      humidity: json['current']['humidity'].toDouble(),
      windSpeed: json['current']['wind_speed'].toDouble(),
      windDirection: json['current']['wind_deg'].toInt(),
      pressure: json['current']['pressure'].toDouble(),
      visibility: json['current']['visibility'].toInt(),
      sunrise: json['current']['sunrise'].toInt(),
      sunset: json['current']['sunset'].toInt(),
      uvIndex: json['current']['uvi'].toDouble(),
      dailyForecast: dailyForecast,
    );
  }
}

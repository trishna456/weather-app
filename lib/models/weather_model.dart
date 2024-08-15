import 'daily_weather_model.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double windSpeed;
  final int windDirection;
  final double feelsLike;
  final double pressure;
  final String description;
  final int visibility;
  final int sunrise;
  final int sunset;
  final double uvIndex;
  final List<DailyWeather> dailyForecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.feelsLike,
    required this.pressure,
    required this.description,
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
    List<DailyWeather> dailyForecast = (json['daily'] as List)
        .map((dailyJson) => DailyWeather.fromJson(dailyJson))
        .toList();

    return Weather(
      cityName: cityName,
      temperature: json['current']['temp'].toDouble(),
      mainCondition: json['current']['weather'][0]['main'],
      humidity: json['current']['humidity'].toDouble(),
      windSpeed: json['current']['wind_speed'].toDouble(),
      windDirection: json['current']['wind_deg'].toInt(),
      feelsLike: json['current']['feels_like'].toDouble(),
      pressure: json['current']['pressure'].toDouble(),
      description: json['current']['weather'][0]['description'],
      visibility: json['current']['visibility'].toInt(),
      sunrise: json['current']['sunrise'].toInt(),
      sunset: json['current']['sunset'].toInt(),
      uvIndex: json['current']['uvi'].toDouble(),
      dailyForecast: dailyForecast,
    );
  }
}

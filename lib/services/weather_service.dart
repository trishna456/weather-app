import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/constants.dart';

class WeatherService {
  final String apiKey;

  final LocationService locationService;

  WeatherService(this.apiKey) : locationService = LocationService(apiKey);
  /*
  Constructor Parameter Initialization:
  WeatherService(this.apiKey): This part of the constructor is shorthand for initializing the apiKey field with the value passed to the constructor.

  Initializer List:
  : locationService = LocationService(apiKey): This part is the initializer list. 
  It initializes the locationService field by creating a new instance of the LocationService class and passing the apiKey to its constructor.
  This happens before the constructor body runs.

  For fields that need to be initialized with values dependent on the constructor parameters,
  the initializer list remains the more concise and preferred approach in Dart.
  */

  Future<Weather> getWeatherByCoordinates(
      double lat, double lon, String units) async {
    // fetching weather data
    final response = await http.get(Uri.parse(
        '$BASE_URL?lat=$lat&lon=$lon&exclude=minutely,hourly&units=$units&appid=$apiKey'));

    if (response.statusCode == 200) {
      // fetching city name from coordinates
      final cityName = await locationService.getCityNameByCoordinates(lat, lon);
      return Weather.fromJson(jsonDecode(response.body), cityName);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

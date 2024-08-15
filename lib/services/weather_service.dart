import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall';
  // ignore: constant_identifier_names
  static const GEO_BASE_URL = 'https://api.openweathermap.org/geo/1.0/';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeatherByCoordinates(
      double lat, double lon, String units) async {
    // fetching weather data
    final response = await http.get(Uri.parse(
        '$BASE_URL?lat=$lat&lon=$lon&exclude=minutely,hourly&units=$units&appid=$apiKey'));

    if (response.statusCode == 200) {
      // fetching city name from coordinates
      final cityName = await getCityNameByCoordinates(lat, lon);
      debugPrint(cityName);
      debugPrint('Fetching weather  successful!');
      return Weather.fromJson(jsonDecode(response.body), cityName);
    } else {
      debugPrint('Error in fetching weather data!');
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> getCurrentPosition() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      throw Exception('Location permissions are permanently denied.');
    }

    // define location settings
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    // fetch the current location
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    return position;
  }

  Future<String> getCityNameByCoordinates(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('${GEO_BASE_URL}reverse?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data[0]['name'];
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to load city name');
    }
  }

  Future<Map<String, double>> getCoordinatesByCityName(String cityName) async {
    final response = await http.get(
      Uri.parse('${GEO_BASE_URL}direct?q=$cityName&limit=1&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {'lat': data[0]['lat'], 'lon': data[0]['lon']};
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to load coordinates');
    }
  }
}

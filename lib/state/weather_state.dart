import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherState with ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;

  Weather? _weather;
  String _units = 'metric';
  String? _error;
  bool _isLoading = false;

  WeatherState(this._weatherService, this._locationService);

  Weather? get weather => _weather;
  String get units => _units;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather({String? cityName}) async {
    double lat;
    double lon;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      if (cityName != null && cityName.isNotEmpty) {
        final coordinates =
            await _locationService.getCoordinatesByCityName(cityName);
        lat = coordinates['lat']!;
        lon = coordinates['lon']!;
      } else {
        Position position = await _locationService.getCurrentPosition();
        lat = position.latitude;
        lon = position.longitude;
      }

      _weather =
          await _weatherService.getWeatherByCoordinates(lat, lon, _units);
    } catch (e) {
      _error = 'Failed to load weather data. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUnits(String units) {
    _units = units;
    notifyListeners();
  }
}

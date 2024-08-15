import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';

class LocationService {
  final String apiKey;

  LocationService(this.apiKey);

  Future<Position> getCurrentPosition() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
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

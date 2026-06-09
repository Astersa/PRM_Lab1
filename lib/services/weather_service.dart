import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

// City coordinates for the Open-Meteo API (no API key required)
const Map<String, (double lat, double lon)> _cityCoords = {
  'Hanoi': (21.0285, 105.8542),
  'Ho Chi Minh City': (10.8231, 106.6297),
  'Da Nang': (16.0544, 108.2022),
  'Bangkok': (13.7563, 100.5018),
  'Singapore': (1.3521, 103.8198),
  'Tokyo': (35.6762, 139.6503),
  'London': (51.5074, -0.1278),
  'New York': (40.7128, -74.006),
};

class WeatherService {
  static List<String> get availableCities => _cityCoords.keys.toList();

  Future<WeatherData> fetchWeather(String city) async {
    final coords = _cityCoords[city];
    if (coords == null) throw Exception('Unknown city: $city');

    final (lat, lon) = coords;
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$lat&longitude=$lon'
      '&current=temperature_2m,apparent_temperature,relative_humidity_2m,'
      'wind_speed_10m,weather_code',
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherData.fromOpenMeteo(city: city, json: json);
    }
    throw Exception(
        'Failed to fetch weather data (${response.statusCode})');
  }
}

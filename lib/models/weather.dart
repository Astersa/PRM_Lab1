class WeatherData {
  final String city;
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final int humidity;
  final int weatherCode;
  final String description;

  const WeatherData({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.weatherCode,
    required this.description,
  });

  String get icon {
    if (weatherCode == 0) return '☀️';
    if (weatherCode <= 3) return '⛅';
    if (weatherCode <= 67) return '🌧️';
    if (weatherCode <= 77) return '❄️';
    if (weatherCode <= 82) return '🌦️';
    return '⛈️';
  }

  String get recommendation {
    if (weatherCode >= 51 && weatherCode <= 67) return '☂️ Take an umbrella!';
    if (weatherCode >= 71 && weatherCode <= 77) return '🧥 Dress warmly – snow expected.';
    if (weatherCode >= 80) return '⛈️ Stay indoors – heavy rain/storms.';
    if (temperature >= 32) return '🥵 Too hot for outdoor sports.';
    if (temperature <= 5) return '🥶 Bundle up – it\'s very cold!';
    if (temperature >= 20 && weatherCode <= 3) {
      return '😎 Great weather for outdoor activities!';
    }
    return '🌤️ Pleasant weather – enjoy your day.';
  }

  factory WeatherData.fromOpenMeteo({
    required String city,
    required Map<String, dynamic> json,
  }) {
    final current = json['current'] as Map<String, dynamic>;
    final code = (current['weather_code'] as num).toInt();

    return WeatherData(
      city: city,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      weatherCode: code,
      description: _describeCode(code),
    );
  }

  static String _describeCode(int code) {
    if (code == 0) return 'Clear sky';
    if (code <= 3) return 'Partly cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 57) return 'Drizzle';
    if (code <= 67) return 'Rain';
    if (code <= 77) return 'Snow';
    if (code <= 82) return 'Rain showers';
    if (code <= 86) return 'Snow showers';
    return 'Thunderstorm';
  }
}

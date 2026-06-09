import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
  String _selectedCity = WeatherService.availableCities.first;
  Future<WeatherData>? _weatherFuture;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    setState(() => _weatherFuture = _service.fetchWeather(_selectedCity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Companion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetch,
          ),
        ],
      ),
      body: Column(
        children: [
          // City selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedCity,
              decoration: InputDecoration(
                labelText: 'Select City',
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              items: WeatherService.availableCities
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  _selectedCity = v;
                  _fetch();
                }
              },
            ),
          ),

          // Weather content
          Expanded(
            child: FutureBuilder<WeatherData>(
              future: _weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return _ErrorView(
                    error: snapshot.error.toString(),
                    onRetry: _fetch,
                  );
                }

                if (!snapshot.hasData) return const SizedBox.shrink();
                return _WeatherContent(weather: snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  final WeatherData weather;
  const _WeatherContent({required this.weather});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Main weather card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(weather.icon, style: const TextStyle(fontSize: 72)),
                  const SizedBox(height: 8),
                  Text(
                    weather.city,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.description,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Details row
          Row(
            children: [
              Expanded(
                child: _DetailCard(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DetailCard(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '${weather.humidity}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Recommendation card
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.tips_and_updates, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      weather.recommendation,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Could not load weather data',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

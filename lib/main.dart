import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
      ),
      home: const WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  
  final String apiKey = "YOUR_API_KEY_HERE"; 
  
  final TextEditingController _cityController = TextEditingController();
  
  String cityName = "Colombo";
  double? temperature;
  String weatherDescription = "Loading...";
  int? humidity;
  double? windSpeed;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchWeather(cityName);
  }

  Future<void> fetchWeather(String city) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cityName = data['name'];
          temperature = data['main']['temp'].toDouble();
          weatherDescription = data['weather'][0]['main'];
          humidity = data['main']['humidity'];
          windSpeed = data['wind']['speed'].toDouble();
          isLoading = false;
        });
      } else {
        showError("City not found or invalid API key!");
      }
    } catch (e) {
      showError("Connection error! Please check your network.");
    }
  }

  void showError(String message) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  List<Color> getBGColors() {
    switch (weatherDescription.toLowerCase()) {
      case 'clouds':
        return [Colors.blueGrey.shade700, Colors.blueGrey.shade900];
      case 'rain':
      case 'drizzle':
        return [Colors.indigo.shade800, Colors.blue.shade900];
      case 'clear':
        return [Colors.orangeAccent.shade400, Colors.blueAccent.shade700];
      default:
        return [const Color(0xFF2E335A), const Color(0xFF1C1B33)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: getBGColors(),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                // 1. Search Bar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter City Name...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          if (_cityController.text.isNotEmpty) {
                            fetchWeather(_cityController.text);
                          }
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),

                // Loading Status or Data View
                isLoading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // 2. Main Weather Display
                              Text(
                                cityName,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                weatherDescription,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                temperature != null
                                    ? '${temperature!.toStringAsFixed(1)}°C'
                                    : '--',
                                style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 40),

                              // 3. Extra Weather Information Card
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildInfoItem(
                                      Icons.water_drop_outlined,
                                      'Humidity',
                                      humidity != null ? '$humidity%' : '--',
                                    ),
                                    _buildInfoItem(
                                      Icons.air,
                                      'Wind Speed',
                                      windSpeed != null ? '$windSpeed m/s' : '--',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Info Cards සඳහා Reusable Widget එක
  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
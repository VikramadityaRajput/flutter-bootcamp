import 'package:flutter/material.dart';

import '../services/weather.dart';
import 'location_screen.dart';

// The first screen: shows a spinner while it fetches weather in the
// background, then replaces itself with the LocationScreen.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData(); // kick off the fetch as soon as the screen loads
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    if (!mounted) return; // screen may be gone by the time the await finishes
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationWeather: weatherData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF2193b0),
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

// Shows the weather. Receives the initial data from the loading screen, then
// can refresh it (📍 button) or look up a city (🏙 button).
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});

  final dynamic locationWeather; // the JSON map handed in from LoadingScreen

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String weatherMessage = '';
  String cityName = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather); // fill the screen from the passed-in data
  }

  // Pull values out of the JSON and store them in state.
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '❌';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = (weatherData['main']['temp'] as num).toDouble();
      temperature = temp.round();
      int condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(Icons.near_me,
                        size: 50.0, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(Icons.location_city,
                        size: 50.0, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text('$temperature°', style: kTempTextStyle),
                    Text(weatherIcon, style: kConditionTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

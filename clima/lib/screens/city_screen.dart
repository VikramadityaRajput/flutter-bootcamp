import 'package:flutter/material.dart';

import '../utilities/constants.dart';

// Lets the user type a city name and sends it back to the LocationScreen
// via Navigator.pop's return value.
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName; // what the user has typed so far

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
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // back with no result
                  },
                  child: const Icon(Icons.arrow_back_ios,
                      size: 50.0, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value; // remember each keystroke
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName); // back, returning the city
                },
                child: const Text('Get Weather', style: kButtonTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// API config. The secret key lives in the gitignored api_keys.dart.
const kApiUrl = 'https://api.openweathermap.org/data/2.5/weather';

// Shared text styles.
const kTempTextStyle = TextStyle(fontSize: 100.0);
const kConditionTextStyle = TextStyle(fontSize: 100.0);
const kMessageTextStyle = TextStyle(fontSize: 40.0);
const kButtonTextStyle = TextStyle(fontSize: 30.0, color: Colors.white);

// Reusable styling for the city-search text field.
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city, color: Colors.white),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

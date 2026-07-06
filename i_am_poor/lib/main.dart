import 'package:flutter/material.dart';

void main() {
  runApp (
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('You are poor, not me'),
        ),
        body: const Center(
          child: Image(
            image: AssetImage('images/poor.png'),
          ),
        ),
      ),
    ),
  );
}
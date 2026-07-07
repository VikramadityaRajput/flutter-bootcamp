import 'package:audioplayers/audioplayers.dart'; //package  for sound playing library
import 'package:flutter/material.dart';

void main() {
  runApp(const XylophoneApp()); //stateless widget
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  // Plays the note matching the given number (1..7).
  void playSound(int noteNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$noteNumber.wav'));
  }

  // Builds one colored key that plays its note when tapped.
  Expanded buildKey(Color color, int noteNumber) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: () {
          playSound(noteNumber);
        },
        child: const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(Colors.red, 1),
              buildKey(Colors.orange, 2),
              buildKey(Colors.yellow, 3),
              buildKey(Colors.green, 4),
              buildKey(Colors.teal, 5),
              buildKey(Colors.blue, 6),
              buildKey(Colors.purple, 7),
            ],
          ),
        ),
      ),
    );
  }
}

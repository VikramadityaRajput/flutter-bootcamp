import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 157, 219, 33),
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: const Text('Dice Game'),
          centerTitle: false,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1; // state: current left die face
  int rightDiceNumber = 1; // state: current right die face

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1; 
      rightDiceNumber = Random().nextInt(6) + 1; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: rollDice,
              child: Image.asset('images/dice$leftDiceNumber.png'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: rollDice,
              child: Image.asset('images/dice$rightDiceNumber.png'),
            ),
          ),
        ],
      ),
    );
  }
}

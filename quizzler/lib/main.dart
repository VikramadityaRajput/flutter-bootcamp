import 'package:flutter/material.dart';

import 'question.dart'; //could put here but convention is one class per file

void main() {
  runApp(const Quizzler()); //default where you define the app later and just say run myapp here
}

class Quizzler extends StatelessWidget { //static
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea( //keeps content clear of the status bar
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0), //padding so it doesnt touch the edge
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questionBank = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('If this sentence is true, then the answer is false', false),
    Question('The number 2,3,5,7,9,11 are prime', false),
  ];

  int questionNumber = 0; // which question we're on 

  // list of correct and wrong icons
  List<Widget> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer =
        questionBank[questionNumber].questionAnswer; 

    setState(() {
      // Was the user right? Add the matching icon to the score keeper.
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      // Move to the next question, or restart when we reach the end.
      if (questionNumber < questionBank.length - 1) {
        questionNumber++;
      } else {
        questionNumber = 0;
        scoreKeeper = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[questionNumber].questionText, // read this question's text
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              checkAnswer(true); // user tapped True
            },
            child: const Text(
              'True',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              checkAnswer(false); // user tapped False
            },
            child: const Text(
              'False',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Row(
          children: scoreKeeper, // show all the ✓/✗ icons collected so far
        ),
      ],
    );
  }
}

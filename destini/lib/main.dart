import 'package:flutter/material.dart';

import 'story_brain.dart';

void main() {
  runApp(const Destini());
}

class Destini extends StatelessWidget {
  const Destini({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: const SafeArea(child: StoryPage()),
      ),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  StoryBrain storyBrain = StoryBrain(); // one brain instance holds all the state

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 12,
            child: Center(
              child: Text(
                storyBrain.getStory(), // ask the brain for the current text
                style: const TextStyle(fontSize: 25.0, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Visibility(
              visible: storyBrain.buttonShouldBeVisible(), // hide at story endings
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    setState(() {
                      storyBrain.nextStory(1); // tapped choice 1
                    });
                  },
                  child: Text(
                    storyBrain.getChoice1(),
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1.0,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  setState(() {
                    storyBrain.nextStory(2); // tapped choice 2
                  });
                },
                child: Text(
                  storyBrain.getChoice2(),
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0), // gap between the buttons and the bottom edge
        ],
      ),
    );
  }
}

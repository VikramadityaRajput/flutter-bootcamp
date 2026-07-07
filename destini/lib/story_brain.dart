import 'story.dart';

// The "brain": owns all the story data AND the logic for moving through it.
// The UI never touches the raw data — it only asks the brain questions.
class StoryBrain {
  int _storyNumber = 0; // which story we're on (private to the brain)

  final List<Story> _storyData = [
    Story(
      storyText:
          'Your car has broken down in the middle of a dark forest. '
          'In the distance you notice a faint, flickering light.',
      choice1: 'Walk toward the light.',
      choice2: 'Stay by the car and wait for help.',
      choice1Destination: 1,
      choice2Destination: 2,
    ),
    Story(
      storyText:
          'You reach a tiny cabin. An old woman opens the door and '
          'offers you a cup of steaming tea.',
      choice1: 'Gratefully accept the tea.',
      choice2: 'Politely decline and head back to the car.',
      choice1Destination: 3,
      choice2Destination: 4,
    ),
    Story(
      storyText:
          'After a cold hour, a tow truck rumbles up the road and '
          'carries you safely home. Nicely done!',
      choice1: '', // empty => this is an ending, first button is hidden
      choice2: 'Restart the adventure.',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
    Story(
      storyText:
          'The tea was enchanted! You blink and find yourself turned '
          'into the old woman\'s newest garden gnome. The end.',
      choice1: '',
      choice2: 'Restart the adventure.',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
    Story(
      storyText:
          'You find the main road, flag down a friendly driver, and '
          'make it home before midnight. Well played!',
      choice1: '',
      choice2: 'Restart the adventure.',
      choice1Destination: 0,
      choice2Destination: 0,
    ),
  ];

  // Getters: the UI asks the brain what to show right now.
  String getStory() => _storyData[_storyNumber].storyText;
  String getChoice1() => _storyData[_storyNumber].choice1;
  String getChoice2() => _storyData[_storyNumber].choice2;

  // At an ending, choice1 is empty — so hide the first button.
  bool buttonShouldBeVisible() => _storyData[_storyNumber].choice1.isNotEmpty;

  // The logic: given which button was tapped, jump to that choice's destination.
  void nextStory(int choiceNumber) {
    final currentStory = _storyData[_storyNumber];
    if (choiceNumber == 1) {
      _storyNumber = currentStory.choice1Destination;
    } else {
      _storyNumber = currentStory.choice2Destination;
    }
  }
}

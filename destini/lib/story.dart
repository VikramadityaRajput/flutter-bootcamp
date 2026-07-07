// One node of the adventure: the text shown, the two choice labels,
// and which story index each choice jumps to.
class Story {
  final String storyText;
  final String choice1;
  final String choice2;
  final int choice1Destination;
  final int choice2Destination;

  const Story({
    required this.storyText,
    required this.choice1,
    required this.choice2,
    required this.choice1Destination,
    required this.choice2Destination,
  });
}

// A Question bundles the text and its correct answer into ONE object,
// so they can never drift out of sync.
class Question {
  String questionText;
  bool questionAnswer;

  // Constructor: how you create a Question, e.g. Question('...', true)
  Question(this.questionText, this.questionAnswer);
}

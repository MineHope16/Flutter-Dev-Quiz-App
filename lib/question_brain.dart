import 'questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuestionBrain {
  int _questionNumber = 0;
  final List<Questions> _questionBank = [
    Questions("The sky is blue.", true),
    Questions("Cats can fly.", false),
    Questions("The Earth is round.", true),
    Questions("Fire is cold.", false),
    Questions("Water boils at 100°C.", true),
    Questions("Humans can breathe underwater without equipment.", false),
    Questions("The capital of France is Paris.", true),
    Questions("2 + 2 equals 5.", false),
    Questions("The sun rises in the east.", true),
    Questions("Bats are mammals.", true),
  ];

  bool isFinished() {
    return _questionNumber < _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }

  void nextQuestion (){

    if (_questionNumber < _questionBank.length - 1){
      _questionNumber++;
    }
  }

  String getQuestionText(){
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer () {
    return _questionBank[_questionNumber].questionAnswer;
  }
}

import 'package:flutter/material.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain quizBrain = QuestionBrain();

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              "Quiz App",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
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

  List<Icon> scores = [];
  int totalScore = 0;

  void getScore(bool choosedAnswer) {
    setState(() {
      if (quizBrain.isFinished()) {
        if (quizBrain.getQuestionAnswer() == choosedAnswer) {
          scores.add(Icon(Icons.check, color: Colors.green,));
          totalScore++;
          quizBrain.nextQuestion();
        }

        else {
          scores.add(Icon(Icons.close, color: Colors.red,));
          quizBrain.nextQuestion();
        }
      }

      else{
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Completed Sucessfully",
          desc: "Your Score is $totalScore",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scores.clear();
                  totalScore = 0;
                  Navigator.pop(context);
                });
              },
              width: 120,
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ))
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                getScore(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                  ))
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                getScore(false);
              },
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: scores,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

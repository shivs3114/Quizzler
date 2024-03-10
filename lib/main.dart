import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

quizz Q = quizz();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Center(
              child: Text(
            'QUIZzler',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          )),
        ),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> sc = [];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = Q.getanswer();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (Q.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        Q.Clear();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        sc = [];
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          sc.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          sc.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        Q.nextQues();
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
          child: Center(
            child: Text(
              Q.getQues(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(fontSize: 20.0),
              )),
        ),
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0),
              )),
        ),
        //TODO:add a score keeper
        Row(children: sc),
        Row(
          children: [
            TextButton(
              child: Icon(
                Icons.clear_rounded,
              ),
              onPressed: () {
                setState(() {
                  sc.clear();
                  Q.Clear();
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/util/hexcolor.dart';


class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  int currentQuestionIndex = 0;
  int score = 0;

  List questionBank = [
    Question.name("The U.S. Declaration of Independence was written in 1776.", true),
    Question.name("The War of 1812 ended in 1814.", true),
    Question.name("Superman would be Batman in a fight.", true),
    Question.name("I like Kotlin", false),
    Question.name(
        "Three rights in the Declaration of Independence include:"
        " \n Life, "
        " \n Liberty, "
        " \n Pursuit of Cheeseburgers",
        false),
    Question.name("The Supreme Law of the Land is the Constitution", true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child:
                Image.asset(
                  "images/flag.png", width: 250, height: 180,)
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                // height: 120.0,
                //mainAxisSize: MainAxisSize.max,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14.4),
                  border: Border.all(
                    width: 2.0,
                    color: Colors.blueGrey.shade400, style: BorderStyle.solid
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(questionBank[currentQuestionIndex].questionText, textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(onPressed: () => _previousQuestion(),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade900
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white,),),
                ElevatedButton(onPressed: () => _checkAnswer(true, context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey.shade900
                ),
                //color: Colors.blueGrey.shade900,
                child: Text("TRUE", style: TextStyle(
                    color: Colors.white)),),
                ElevatedButton(onPressed: () => _checkAnswer(false, context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey.shade900
                  ),
                  child: Text("FALSE", style: TextStyle(
                    color: Colors.white
                  ),),),
                ElevatedButton(onPressed: () => _nextQuestion(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey.shade900
                  ),
                  child: Icon(Icons.arrow_forward, color: Colors.white,),),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Score: $score",
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _checkAnswer( bool value, BuildContext context){
    if(value == questionBank[currentQuestionIndex].isCorrect){
      final snackbar = SnackBar(
        backgroundColor: Colors.green,
      duration: Duration(milliseconds: 1000),content: Text("Correct!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _nextQuestion();
      _incrementScore();
    }else{
      final snackbar = SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 1000),
          content: Text("Sorry, incorrect!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _nextQuestion();
    }
  }

  _nextQuestion(){
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questionBank.length;
    });
  }

  _previousQuestion(){
    setState(() {
      currentQuestionIndex = (currentQuestionIndex - 1) % questionBank.length;
    });
  }

  _incrementScore(){
    setState(() {
      score++;
    });
  }

}


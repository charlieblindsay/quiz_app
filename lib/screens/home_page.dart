import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quiz_app/utilities/network.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/quiz_brain.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  QuizBrain quizBrain = QuizBrain();
  Future<List<Question>> questionList;

  Future<List<Question>> getQuizData() async {
    List<Question> questionList = [];

    NetworkHelper network = NetworkHelper(
        'https://opentdb.com/api.php?amount=3');
    var quizData = await network.getData();
    print(quizData['results']);
    for (var result in quizData['results']){
      print('yes');
      print(result);
      String question = result['question'];
      String answer = result['correct_answer'];
      List<String> incorrectAnswers = result['incorrect_answers'];
      questionList.add(Question(question: question, correctAnswer: answer, incorrectAnswers: incorrectAnswers));
    }

    return questionList;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionList = getQuizData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('hello world'),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    onSurface: Colors.teal,
                  ),
                  onPressed: () {
                    print('pressed');
                  },
                  child:
                      FutureBuilder(
                        future: questionList,
                      builder: (BuildContext context, AsyncSnapshot<List<Question>> questionSnapshot){
                          if (questionSnapshot.hasData){
                            return Text('${questionSnapshot.data[quizBrain.questionNumber].correctAnswer}');
                          } else{
                            return Text('loading questions');
                          }
                      },),
                      ),
            ],
          ),
        ));
  }
}

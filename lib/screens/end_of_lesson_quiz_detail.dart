import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learn_tagalog/models/lesson.dart';
import 'package:learn_tagalog/utilities/quiz_brain.dart';
import 'package:learn_tagalog/screens/results_detail.dart';
import 'package:learn_tagalog/widgets/quiz_button.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EndOfLessonQuizDetail extends StatefulWidget {
  final List<Lesson> questionContent;
  final String quizTitle;

  EndOfLessonQuizDetail({this.questionContent, this.quizTitle});

  @override
  _EndOfLessonQuizDetailState createState() => _EndOfLessonQuizDetailState();
}

class _EndOfLessonQuizDetailState extends State<EndOfLessonQuizDetail> {
  double _progress = 0.0;
  int correctAnswerCount = 0;
  AudioPlayer player;

  QuizBrain quizBrain;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    quizBrain = QuizBrain();
    quizBrain.lessonBank.addAll(widget.questionContent);
    quizBrain.checkOptions();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future playOption(String optionAudio) async {
    await player.setAsset(optionAudio);
    player.play();
  }

  void checkAnswer(String userAnswer) {
    setState(
      () {
        if (userAnswer.contains(quizBrain.getEnglishText()) == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Correct answer',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              duration: Duration(seconds: 1),
            ),
          );
          correctAnswerCount++;

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Wrong answer',
                style: TextStyle(color: Colors.red),
              ),
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        quizBrain.nextQuestion(context, ResultsDetail(
          userResults: correctAnswerCount,
          numOfQs: widget.questionContent.length,
        ));
        quizBrain.checkOptions();
        _progress++;

      },
    );
    //showResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeColor(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.quizTitle + ' Review Quiz',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Container(
                  width: 300.0,
                  child: LinearPercentIndicator(
                    lineHeight: 10.0,
                    backgroundColor: Colors.white,
                    progressColor: Colors.amber,
                    percent:
                        _progress / widget.questionContent.length.toDouble(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      'What is the ' +
                          quizBrain.getType() +
                          ' for ' +
                          quizBrain.getTagalogText() +
                          '?',
                      style: TextStyle(fontSize: 23.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                reverse: false,
                children: [
                  QuizButton(
                    buttonTxt: quizBrain.getEnglishText(),
                    onTap: () {
                      setState(() {
                        playOption(quizBrain.getAudio());
                        checkAnswer(quizBrain.getEnglishText());
                        print(_progress / widget.questionContent.length.toDouble());
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  QuizButton(
                    buttonTxt:
                        quizBrain.lessonBank[quizBrain.getOpt1Index()].engWord,
                    onTap: () {
                      setState(
                        () {
                          checkAnswer(quizBrain
                              .lessonBank[quizBrain.getOpt1Index()].engWord);
                          playOption(quizBrain
                              .lessonBank[quizBrain.getOpt1Index()].audio);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  QuizButton(
                    buttonTxt:
                        quizBrain.lessonBank[quizBrain.getOpt2Index()].engWord,
                    onTap: () {
                      setState(
                        () {
                          checkAnswer(quizBrain
                              .lessonBank[quizBrain.getOpt2Index()].engWord);
                          playOption(quizBrain
                              .lessonBank[quizBrain.getOpt2Index()].audio);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  QuizButton(
                    buttonTxt:
                        quizBrain.lessonBank[quizBrain.getOpt3Index()].engWord,
                    onTap: () {
                      setState(
                        () {
                          checkAnswer(quizBrain
                              .lessonBank[quizBrain.getOpt3Index()].engWord);
                          playOption(quizBrain
                              .lessonBank[quizBrain.getOpt3Index()].audio);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learn_tagalog/models/lesson.dart';
import 'package:learn_tagalog/screens/end_of_lesson_quiz_detail.dart';

class LessonLogic {
  AudioPlayer player = AudioPlayer();
  int index = 0;
  double progressPercent = 0;
  List<Lesson> lessonContent = [];

  String getTagalogWord() {
    return lessonContent[index].name;
  }

  String getEngWord() {
    return lessonContent[index].engWord;
  }

  IconData getIcon() {
    return lessonContent[index].icon;
  }

  Color getIconColor() {
    return lessonContent[index].color;
  }

  String getAudio() {
    return lessonContent[index].audio;
  }

  double getProgress(){
    return progressPercent /
        lessonContent.length.toDouble();
  }

  playAudio() async {
    await player.setAsset(lessonContent[index].audio);
    await player.setSpeed(1);
    print(await player.setAsset(lessonContent[index].audio));
    player.play();
  }

  playHalfSpeed() async {
    await player.setAsset(lessonContent[index].audio);
    await player.setSpeed(0.5);
    player.play();
  }

  void reset() {
    index = 0;
    progressPercent = 0.0;

  }

  int nextWord() {
    if (index < lessonContent.length) {
      index++;
      progressPercent++;
    }
   // print(index);
    return index;
  }

  double phraseFontSize() {
    if (lessonContent[index].type == 'phrase') {
      return 28.0;
    } else {
      return 40.0;
    }
  }

  void finishedAlertDialog(BuildContext context, EndOfLessonQuizDetail quiz ) {
    if (index >= lessonContent.length) {
      reset();
      print('button pressed');
      showAlert(
        context: context,
        title: 'Review lesson?',
        body: 'Test your knowledge by answering questions about this lesson.',
        actions: [
          AlertAction(
            text: 'Yes',
            onPressed: () {
              index = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => quiz,
                ),
              );
            },
          ),
          AlertAction(
            text: 'Redo',
            onPressed: () {
              reset();
              // index = 0;
              // progressPercent = 0.0;
              print('pressed redo' + ' ' + index.toString());
            },
          )
        ],
      );
    }
  }
  bool isFinished(){
    if(index >= lessonContent.length){
      return true;
    }else{
      return false;
    }
  }
}

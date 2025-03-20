import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/lesson.dart';

class QuizBrain {
  int lessonNumber = 0;
  int option1;
  int option2;
  int option3;

  List<Lesson> lessonBank = [];

  String getTagalogText() {
    return lessonBank[lessonNumber].name;
  }

  String getEnglishText() {
    return lessonBank[lessonNumber].engWord;
  }

  String getAudio() {
    return lessonBank[lessonNumber].audio;
  }

  IconData getIcon() {
    return lessonBank[lessonNumber].icon;
  }

  String getType() {
    return lessonBank[lessonNumber].type;
  }

  int getOpt1Index() {
    return option1;
  }

  int getOpt2Index() {
    return option2;
  }

  int getOpt3Index() {
    return option3;
  }

  void nextQuestion(BuildContext context, Widget resultsPage) {

    if (lessonNumber >= lessonBank.length - 1) {
      print('end of list');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => resultsPage,
        ),
      );
    } else {
      if (lessonNumber < lessonBank.length - 1) {
        lessonNumber++;
      }
    }
  }



  int getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    if (lessonNumber == i && !(lessonNumber >= list.length)) {
      i++;
    } else if (lessonNumber == i && lessonNumber == list.length) {
      i--;
    }
    return i;
  }

  void checkOptions() {
    option1 = getRandomElement(lessonBank);
    option2 = getRandomElement(lessonBank);
    option3 = getRandomElement(lessonBank);
    int numOfQs = lessonBank.length - 1;

    if (option1 == option2 || option1 == lessonNumber) {
      if (!(option1 >= numOfQs)) {
        option1++;
      } else if (option1 == option3 || !(option1 >= numOfQs)) {
        if (option1 == lessonNumber) {
          option1++;
        }
      }
    } else if (option1 != 0) {
      option1--;
    }

    if (option2 == option3 || !(option2 >= numOfQs)) {
      if (option2 == 0) {
        option2++;
      } else if (option2 == option1 || !(option2 >= numOfQs)) {
        if (option2 == lessonNumber) {
          option2++;
        }
      }
    } else if (option2 != 0) {
      option2--;
    }
    if (option3 == option1 || !(option3 >= numOfQs)) {
      if (option3 == 0) {
        option3++;
      } else if (option3 == option2 || !(option3 >= numOfQs)) {
        if (option3 == 0 || option3 == lessonNumber) {
          option3++;
        }
      }
    } else if (option3 != 0) {
      option3--;
    }
  }

  void reset() {
    lessonNumber = 0;
  }

  bool isFinished() {
    if (lessonNumber >= lessonBank.length - 1) {
      print('now printing true');
      return true;
    } else {
      print('printing false');
      return false;
    }
  }
}
